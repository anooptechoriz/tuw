import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:tuw_services/components/routes_manager.dart';
import 'package:tuw_services/components/theme_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:tuw_services/firebase_options.dart';
import 'package:tuw_services/providers/data_provider.dart';
import 'package:tuw_services/providers/otp_provider.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:tuw_services/providers/servicer_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tuw_services/API/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("Firebase initialized successfully");

    // Initialize Firebase messaging
    await FirebaseApi().initNotifications();
    print("Firebase messaging initialized successfully");
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

  try {
    await Hive.initFlutter();
    await Hive.openBox("LocalLan");
    await Hive.openBox("token");
    await Hive.openBox("service");
    await Hive.openBox("regionid");
    print("Hive initialized successfully");
  } catch (e) {
    print("Hive initialization failed: $e");
    // Try alternative initialization with a specific directory
    try {
      // Use app's internal storage directory
      final Directory appDir = Directory('/data/data/com.tuwconnect.services/app_flutter');
      if (!await appDir.exists()) {
        await appDir.create(recursive: true);
      }
      Hive.init(appDir.path);
      await Hive.openBox("LocalLan");
      await Hive.openBox("token");
      await Hive.openBox("service");
      await Hive.openBox("regionid");
      print("Hive initialized with manual path");
    } catch (e2) {
      print("Hive manual path initialization also failed: $e2");
      // Last resort - try with temporary directory
      try {
        Hive.init('/tmp');
        await Hive.openBox("LocalLan");
        await Hive.openBox("token");
        await Hive.openBox("service");
        await Hive.openBox("regionid");
        print("Hive initialized with temp directory");
      } catch (e3) {
        print("All Hive initialization methods failed: $e3");
      }
    }
  }
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
// ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  String lang = '';
  Locale locale = const Locale('en', '');

  void setLocale(Locale value) async {
    setState(() {
      locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DataProvider()),
          ChangeNotifierProvider(create: (_) => OTPProvider()),
          ChangeNotifierProvider(create: (_) => ServicerProvider()),
        ],
        child: MaterialApp(
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('hi', ''), // Hindi
            Locale('ar', ''), // arabic
          ],
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: 'Tuw Services',
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(context).copyWith(useMaterial3: true),
          initialRoute: Routes.splashScreen,
          onGenerateRoute: RouteGenerator.getRoute,
        ));
  }
}
