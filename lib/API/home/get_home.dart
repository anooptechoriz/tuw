// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/get_home.dart';
import 'package:social_media_services/providers/data_provider.dart';

getHome(
  BuildContext context,
//  {id, bool? changeLan}
) async {
  //  final otpProvider = Provider.of<OTPProvider>(context, listen: false);
  final provider = Provider.of<DataProvider>(context, listen: false);
  String? apiToken = Hive.box("token").get('api_token');
  final String id = Hive.box("LocalLan").get('lang_id');

  // if (apiToken == null) return;
  if (apiToken == null) {
    apiToken = '';
  }
  ;
  try {
    // String? url;
    // if (changeLan == true) {
    //   url = "$home?language_id=$id";
    // } else {
    //   url = home;
    // }
    var response = await http.post(Uri.parse("$home?language_id=$id"),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse['result'] == false) {
        await Hive.box("token").clear();

        return;
      }

      final homeData = HomeModel.fromJson(jsonResponse);
      // homeData.homebanner?.add(Homebanner(
      //     target: 'static',
      //     title: 'title',
      //     image:
      //         'https://www.leonardodavincischool.org/sites/main/files/imagecache/lightbox/main-images/camera_lense_0.jpeg'));
      // homeData.homebanner?.add(Homebanner(
      //     target: 'static',
      //     title: 'title 2',
      //     image:
      //         'https://static.photocdn.pt/images/articles/2017/11/29/articles/2017_8/iStock-641093712-min-1.webp'));
      // homeData.homebanner?.add(Homebanner(
      //     target: 'static',
      //     title: 'title 3',
      //     image:
      //         'https://as1.ftcdn.net/v2/jpg/07/06/77/90/1000_F_706779057_gMAIM3zJMi1OXCGjRklwOCoE4bITO0WF.jpg'));
      // homeData.homebanner?.add(Homebanner(
      //     target: 'static',
      //     title: 'title 4',
      //     image:
      //         'https://as1.ftcdn.net/v2/jpg/08/19/94/00/1000_F_819940079_6dUbjhbYxkomZoqgBjRHCPm5yDxKWsyO.jpg'));
      provider.homeModelData(homeData);
      print(jsonResponse);
    } else {
      // print(response.statusCode);
      // print(response.body);
      // print('// went wrong');
    }
  } on Exception catch (_) {
    // Print("// Went Wrong1", context);
  }
}
