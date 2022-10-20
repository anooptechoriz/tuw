// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/get_home.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/snack_bar.dart';

getHome(BuildContext context) async {
  //  final otpProvider = Provider.of<OTPProvider>(context, listen: false);
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  try {
    var response = await http.post(Uri.parse(home),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      final homeData = HomeModel.fromJson(jsonResponse);
      provider.homeModelData(homeData);
      print(jsonResponse);
    } else {
      // print(response.statusCode);
      // print(response.body);
      // print('Something went wrong');
    }
  } on Exception catch (_) {
    showSnackBar("Something Went Wrong1", context);
  }
}
