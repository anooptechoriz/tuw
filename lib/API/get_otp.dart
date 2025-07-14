// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/model/otp/get_otp.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/otp_provider.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_services/utils/animatedSnackBar.dart';

getOtp(
    {required BuildContext context,
    countryCode,
    phoneNo,
    resend,
    String? appSignature}) async {
  final String id = Hive.box("LocalLan").get('lang_id');
  try {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final otpProvider = Provider.of<OTPProvider>(context, listen: false);
    StringBuffer urlsBuffer = StringBuffer(
        '$apiUser/request_otp?countrycode=$countryCode&phone=$phoneNo&language_id=$id');
    if (appSignature != null && Platform.isAndroid) {
      urlsBuffer.write('&signature_key=$appSignature');
    }
    final url = Uri.parse("$urlsBuffer");
    print('getOtp---------$url');
    var response = await http.post(url, headers: {
      "device-id": provider.deviceId ?? '',
    });
    if (response.statusCode != 200) {
      log("Something Went Wrong - - ");
      return;
    }

    var jsonResponse = jsonDecode(response.body);
    //  print('otpmes:${jsonResponse['result']['OTP']}');
    final result = jsonResponse["result"];
    final action = jsonResponse["action"];
    print(action);

    if (result == false) {
      try {
        final errorMessage = jsonResponse["message"]["phone"][0];
        showAnimatedSnackBar(context, errorMessage);
      } catch (_) {}
      try {
        final errorMessage = jsonResponse["message"];
        showAnimatedSnackBar(context, errorMessage);
      } catch (_) {}
      return;
    }

    var getOtpData = GetOtp.fromJson(jsonResponse);

    otpProvider.getOtpData(getOtpData);

    if (resend == true) {
      return;
    }
    navigateToOtp(context);
  } on Exception catch (e) {
    log("Something Went Wrong10");
    print(e);
  }
}

navigateToOtp(context) {
  Navigator.pushNamed(context, Routes.otpScreen);
}
