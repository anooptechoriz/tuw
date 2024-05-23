import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';

class FCM {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<String?> token() async {
    return await messaging.getToken();
  }

  static Future<void> storeFCMToken(String? fcm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (fcm != null) {
      await prefs.setString('fcm', fcm);
    }
  }

  //---------------------------------------------APIs--------------------------------------------------------//

  static Future<void> requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
    // debugPrint('User granted permission: ${settings.authorizationStatus} fcm');
  }

  static init() async {
    await requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM token --->> $token');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
  }
}
