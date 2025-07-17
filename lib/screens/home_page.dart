import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/constants/constant.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import '../API/get_chat_list.dart';
import '../providers/data_provider.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  const HomePage({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String lang = '';
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _screens = [
    const ServiceHomePage(),
    const MessagePage(
      isHome: true,
    )
  ];
  Future<bool> handleBackButton() async {
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      // If the drawer is open, close it
      _scaffoldKey.currentState!.closeEndDrawer();
      return false; // Do not exit the app
    } else {
      // If the drawer is not open, exit the app
      SystemNavigator.pop();
      return true;
    }
  }

  @override
  void initState() {
    super.initState();

    _firebaseMessagingInit();
    _selectedIndex = widget.selectedIndex;
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getChatList(
        context,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    print("did");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final w = MediaQuery.of(context).size.width;
    // final mobWth = ResponsiveWidth.isMobile(context);
    // final smobWth = ResponsiveWidth.issMobile(context);
    final provider = Provider.of<DataProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        endDrawer: SizedBox(
          height: size.height * 0.825,
          // width: mobWth
          //     ? size.width * 0.6
          //     : smobWth
          //         ? w * .7
          //         : w * .75,
          child: const CustomDrawer(),
        ),
        bottomNavigationBar: Stack(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.shade400,
                  offset: const Offset(6, 1),
                ),
              ]),
            ),
            SizedBox(
              height: 44,
              child: GNav(
                tabMargin: const EdgeInsets.symmetric(
                  vertical: 0,
                ),
                gap: 0,
                backgroundColor: ColorManager.whiteColor,
                mainAxisAlignment: MainAxisAlignment.center,
                activeColor: ColorManager.grayDark,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: ColorManager.primary.withOpacity(0.4),
                color: ColorManager.black,
                tabs: [
                  GButton(
                    // text: ' Home',
                    icon: FontAwesomeIcons.message,
                    leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(ImageAssets.homeIconSvg)),
                  ),
                  GButton(
                    icon: FontAwesomeIcons.message,
                    // text: ' Chat',
                    leading: Stack(children: [
                      InkWell(
                        child: SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(ImageAssets.chatIconSvg)),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: new Container(
                          padding: EdgeInsets.all(1),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          child: (provider.chatListDetails != null)
                              ? Text(
                                  provider.chatListDetails!.chatMessage!.data!
                                          .isNotEmpty
                                      ? provider.chatListDetails!.chatMessage!
                                          .data![0].unreadCount
                                          .toString()
                                      : '0',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Text('0', textAlign: TextAlign.center),
                        ),
                      )
                    ]),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  // getChatList(
                  //   context,
                  // );
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
            Positioned(
                left: lang == 'ar' ? 5 : null,
                right: lang != 'ar' ? 5 : null,
                bottom: 0,
                child: Builder(
                  builder: (context) => InkWell(
                    onTap: () {
                      // String? apiToken = Hive.box("token").get('api_token');
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.menu,
                        size: 25,
                        color: ColorManager.black,
                      ),
                    ),
                  ),
                ))
          ],
        ),
        body: _screens[_selectedIndex],
      ),
    );
  }

  //--------------------------------------------Push Notifications------------------------------------------------//

  _firebaseMessagingInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getFirebaseMessages();
    String? fcm = prefs.getString('fcm');
    String? token = await FirebaseMessaging.instance.getToken();
    if (fcm != token) {
      await prefs.setString('fcm', token ?? '');
    }
    fcmToken = prefs.getString('fcm') ?? '';
    debugPrint('FCM token --->> $fcmToken');

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => _handleMessageData(message.data),
    );
  }

  getFirebaseMessages() async {
    RemoteMessage? initialMsg =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMsg != null) {
      _handleMessageData(initialMsg.data);
    }
  }

  void _handleMessage(RemoteMessage message) async {
    sendLocalNotification(message);
  }

  sendLocalNotification(RemoteMessage message) async {
    debugPrint("Notification data ${message.data}");
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) =>
                _handleMessageData(message.data));
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async =>
          _handleMessageData(message.data),
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // titledescription
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    RemoteNotification notification = message.notification!;

    AndroidNotificationDetails? androidNotificationDetails;
    if (Platform.isAndroid) {
      AndroidNotification android = message.notification!.android!;
      androidNotificationDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        icon: android.smallIcon,
        // other properties...
      );
    }

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(android: androidNotificationDetails),
    );
  }

  void _handleMessageData(Map<String, dynamic> data) async {}
}
