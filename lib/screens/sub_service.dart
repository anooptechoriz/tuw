import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:tuw_services/API/endpoint.dart';
import 'package:tuw_services/API/home/get_subService.dart';
import 'package:tuw_services/components/assets_manager.dart';
import 'package:tuw_services/components/color_manager.dart';
import 'package:tuw_services/components/styles_manager.dart';
import 'package:tuw_services/model/get_home.dart';
import 'package:tuw_services/providers/data_provider.dart';
import 'package:tuw_services/responsive/responsive.dart';
import '../l10n/app_localizations.dart';
import 'package:tuw_services/responsive/responsive_width.dart';
import 'package:tuw_services/screens/home_page.dart';
import 'package:tuw_services/loading%20screens/loading_page.dart';
import 'package:tuw_services/utils/get_location.dart';
import 'package:tuw_services/widgets/backbutton.dart';
import 'package:tuw_services/widgets/custom_drawer.dart';
import '../model/chat_list.dart';

class SubServicesPage extends StatefulWidget {
  const SubServicesPage({Key? key, required this.homeService})
      : super(key: key);
  final Services homeService;

  @override
  State<SubServicesPage> createState() => _SubServicesPageState();
}

class _SubServicesPageState extends State<SubServicesPage> {
  final int _selectedIndex = 0;
  String lang = '';
  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get('lang');
  }

  @override
  Widget build(BuildContext context) {
    final mob = Responsive.isMobile(context);
    final str = AppLocalizations.of(context)!;
    final h = MediaQuery.of(context).size.height;

    final provider = Provider.of<DataProvider>(context, listen: true);
    final homeData = provider.subServicesModel?.subservices;
    final w = MediaQuery.of(context).size.width;
    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);
    ChatListModel? chatListDetails = provider.chatListDetails;
    ChatMessage? chatMessage = chatListDetails?.chatMessage;
    List<MessageData> data = chatMessage?.data ?? [];
    // String unreadCount = (data.isEmpty ? data[0].unreadCount : 0).toString();
    int unreadCount = data
            .firstWhere((element) => element.id != null,
                orElse: () => MessageData())
            .unreadCount ??
        0;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawer: SizedBox(
        height: h * 0.825,
        width: mobWth
            ? w * 0.6
            : smobWth
                ? w * .7
                : w * .75,
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
              tabMargin: const EdgeInsets.symmetric(vertical: 0),
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
                  icon: FontAwesomeIcons.message,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  const HomePage(selectedIndex: 0)));
                    },
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(ImageAssets.homeIconSvg)),
                  ),
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  const HomePage(selectedIndex: 1)));
                    },
                    child: Stack(
                      children: [
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
                            child: Text(
                              unreadCount.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              selectedIndex: _selectedIndex,
              // onTabChange: (index) {
              //   if (mounted) {
              //     Navigator.pushNamedAndRemoveUntil(
              //         context, Routes.homePage, (route) => false);
              //   }
              // },
            ),
          ),
          Positioned(
            left: lang == 'ar' ? 5 : null,
            right: lang != 'ar' ? 5 : null,
            bottom: 0,
            child: Builder(
              builder: (context) => InkWell(
                onTap: () {
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
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(w * .02, mob ? 10 : 10, w * .02, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BackButton2(),
                      Spacer(),
                      CircleAvatar(
                          backgroundColor: Color(0xff08dc2c),
                          child: Image.asset('assets/logo/app-logo-T.jpg',
                              height: 30, width: 30))
                    ],
                  ),
                ),
                Text(
                  // str.se_sub_services,
                  "${str.choose} ${widget.homeService.service}",
                  style: getBoldtStyle(color: ColorManager.black, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: mob ? 130 : 100,
                        childAspectRatio: 3 / 3,
                        crossAxisSpacing: 14,
                        mainAxisExtent: mob ? 123 : 100,
                        mainAxisSpacing: 20),
                    itemCount: homeData?.length ?? 0,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) {
                            return const LoadingListPage();
                          }));
                          final id = homeData?[index].id;
                          await requestExplorerLocationPermission(context);
                          getSubService(context, id, false, widget.homeService);

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (ctx) {
                          //   return const ServicerPage();
                          // }));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.grey.shade300,
                                  offset: const Offset(2, 2.5),
                                ),
                              ],
                              color: ColorManager.whiteColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: mob ? 70.0 : 50,
                                  height: mob ? 70.0 : 50,
                                  child: SvgPicture.network(
                                    '$endPoint${homeData?[index].image}',
                                    color: ColorManager.primary2,
                                  )),
                              Text(homeData?[index].service ?? '',
                                  textAlign: TextAlign.center,
                                  style: getRegularStyle(
                                      color: ColorManager.serviceHomeGrey,
                                      fontSize:
                                          (homeData?[index].service?.length ??
                                                      0) >
                                                  13
                                              ? 10
                                              : 12)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
