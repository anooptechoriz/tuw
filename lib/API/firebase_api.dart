import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constant.dart';

// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title ?? 'No title'}");
  print("Body: ${message.notification?.body ?? 'No body'}");
  print("PayLoad: ${message.data}");
}

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
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }



  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    // Get FCM token
    final fCMToken = await _firebaseMessaging.getToken();
    if (fCMToken != null) {
      fcmToken = fCMToken;

      // Store token in SharedPreferences for persistence
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm', fCMToken);

      debugPrint("FCM Token initialized successfully");
      debugPrint("FCM Token stored in SharedPreferences");
    } else {
      fcmToken = '';
      log("FCM Token is null - Firebase may not be properly configured");
    }

    // Initialize push notifications
    initPushNotifications();
  }

  // Method to get stored FCM token
  static Future<String?> getStoredFCMToken() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('fcm');
    if (storedToken != null && storedToken.isNotEmpty) {
      fcmToken = storedToken;
      log("Retrieved FCM token from storage: ${storedToken.substring(0, 20)}...");
      return storedToken;
    }
    log("No FCM token found in storage");
    return null;
  }

  // Debug method to check current FCM token status
  static Future<void> debugFCMTokenStatus() async {
    print("=== FCM TOKEN DEBUG ===");
    print("Global fcmToken variable: ${fcmToken.isEmpty ? 'EMPTY' : '${fcmToken.substring(0, 20)}...'}");
    print("Global fcmToken length: ${fcmToken.length}");

    // Also check SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('fcm');
    print("Stored FCM token: ${storedToken?.isEmpty ?? true ? 'EMPTY' : '${storedToken!.substring(0, 20)}...'}");

    // Check API token too (from Hive)
    final apiToken = Hive.box("token").get('api_token');
    print("API token: ${apiToken == null ? 'NULL' : 'EXISTS'}");
    print("======================");
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
