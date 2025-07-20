// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:tuw_services/API/address/getUserAddress.dart';
import 'package:tuw_services/API/get_chat_list.dart';
import 'package:tuw_services/API/get_countries.dart';
import 'package:tuw_services/API/get_serviceManProfileDetails.dart';
import 'package:tuw_services/API/get_language.dart';
import 'package:tuw_services/API/home/get_home.dart';
import 'package:tuw_services/components/routes_manager.dart';
import 'package:tuw_services/providers/data_provider.dart';
import 'package:tuw_services/API/viewProfile.dart';
import 'package:tuw_services/utils/getLocalLanguage.dart';

Future<void> initPlatformState(BuildContext context) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  String? deviceId;

  try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    } else {
      deviceId = 'Unknown platform';
    }
    provider.deviceId = deviceId;
  } on PlatformException {
    deviceId = 'Failed to get deviceId.';
  }

  final apiToken = Hive.box("token").get('api_token');

  print(apiToken);
  // if (provider.isInternetConnected == false) {
  //   Navigator.pushNamed(context, Routes.noConnectionPage);
  //   return;
  // }

  if (apiToken == null) {
    log("API token is null");
    gotoNextPage(context);
  } else {
    await viewProfile(context);
    await getUserAddress(context);
    await getChatList(context);
    await getHome(context);
    await getCountriesData(context);
    provider.viewProfileModel?.userdetails?.userType == 'customer'
        ? null
        : await getServiceManProfileFun(context);

    gotoHomePage(context);
  }
  print(provider.deviceId);
}

gotoNextPage(BuildContext context) async {
  // getlocalLanguage(context);
  await getLanguageData(context);
  await getCountriesData(context);

  Timer(const Duration(seconds: 1), () {
    Navigator.pushReplacementNamed(context, Routes.introductionScreen);
  });
}

gotoHomePage(BuildContext context) async {
  await getLanguageData(context);
  getlocalLanguage(context);
  Timer(const Duration(seconds: 1), () {
    Navigator.pushReplacementNamed(context, Routes.homePage);
  });
}
