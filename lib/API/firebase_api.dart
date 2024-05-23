import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../constants/constant.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void handleMsg(RemoteMessage? remoteMessage) {
    if (remoteMessage == null) return;
    //navigatorKey.currentState!.pushReplacementNamed(HomeScreen.routeName);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleMsg);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMsg);
    FirebaseMessaging.onBackgroundMessage(handleBAckgroundMsg);
  }

  Future<void> handleBAckgroundMsg(RemoteMessage message) async {
    print("Title :${message.notification!.title}");
    print("Body :${message.notification!.body}");
    print("PayLoad :${message.data}");
    handleMsg(message);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // _firebaseMessaging.getToken().then((token) {
    //   print("FCM Token: $token");
    // });
    final fCMToken = await _firebaseMessaging.getToken();
    fcmToken = fCMToken!;
    log("FCM Token: $fCMToken");
    initPushNotifications();
  }
}
// import 'package:firebase_messaging/firebase_messaging.dart';

// import '../constants/constant.dart';
// import '../main.dart';

// class FirebaseApi {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   void handleMsg(RemoteMessage? remoteMessage) {
//     if (remoteMessage == null) return;
//     //navigatorKey.currentState!.pushReplacementNamed(HomeScreen.routeName);
//   }

//   Future initPushNotifications() async {
//     // await FirebaseMessaging.instance
//     //     .setForegroundNotificationPresentationOptions(
//     //         alert: true, badge: true, sound: true);
//      await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: false, badge: false, sound: false);

//     FirebaseMessaging.instance.getInitialMessage().then(handleMsg);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMsg);
//     try {
//       FirebaseMessaging.onBackgroundMessage(handleBAckgroundMsg);
//     } catch (e) {
//       print('fcm error : $e');
//     }
    
//   }

  

//   Future<void> initNotifications({required bool isFirstime}) async {
//     if (isFirstime) {
//       await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
      
//     }
    
//     // _firebaseMessaging.getToken().then((token) {
//     //   print("FCM Token: $token");
//     // });
    
//     String? token = await _firebaseMessaging.getAPNSToken();
//     if (token != null) {
//       print("APNS Token : $token");
//       final fCMToken = await _firebaseMessaging.getToken();
//     fcmToken = fCMToken!;
//     print("FCM Token: $fCMToken");
//     if (isFirstime) {
//         initPushNotifications();
//       }
//    // initPushNotifications();
//     }else {
//       await Future<void>.delayed(
//         const Duration(
//           seconds: 3,
//         ),
//       );
//       token = await _firebaseMessaging.getAPNSToken();
//       if (token != null) {
//         print("APNS Token : $token");
//        final fCMToken = await _firebaseMessaging.getToken();
//     fcmToken = fCMToken!;
//     print("FCM Token: $fCMToken");
//     if (isFirstime) {
//         initPushNotifications();
//       }
//     //initPushNotifications();
//       }
//     }
    
//   }
// }
