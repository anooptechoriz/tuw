import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tuw_services/API/endpoint.dart';
import 'package:tuw_services/components/routes_manager.dart';
import 'package:tuw_services/model/serviceManLIst.dart';
import 'package:tuw_services/providers/data_provider.dart';
import 'package:tuw_services/providers/servicer_provider.dart';
import 'package:tuw_services/screens/serviceman/servicer.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

getServiceMan(BuildContext context, id, homeservice) async {
  //  final otpProvider = Provider.of<OTPProvider>(context, listen: false);
  final provider = Provider.of<DataProvider>(context, listen: false);
  final userDetails = provider.viewProfileModel?.userdetails;
  final String lanId = Hive.box("LocalLan").get('lang_id');
  // provider.subServicesModel = null;
  String? apiToken = Hive.box("token").get('api_token');
  // if (apiToken == null) return;
  if (apiToken == null) {
    apiToken = '';
  }
  try {
    log('user details -------- ${userDetails?.latitude}');
    // if (userDetails?.latitude == null) {
    Position position = await determinePosition();
    log('position-------_${position.latitude}------${position.longitude}');
    userDetails?.latitude = position.latitude.toString();
    userDetails?.longitude = position.longitude.toString();
    // }
    var response = await http.post(
        Uri.parse(
            '$servicemanList?service_id=$id&page=1&latitude=${position.latitude}&longitude=${position.longitude}&language_id=${lanId}'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log('getServiceMan------------>> ${response.body}------${response.request}');
      print("Navigation active");
      navToServiceMan(context, id, homeservice);
      if (jsonResponse['result'] == false) {
        await Hive.box("token").clear();
        return;
      }

      final serviceManListData = ServiceManListModel.fromJson(jsonResponse);
      provider.getServiceManData(serviceManListData);
      // if (provider.serviceManListModel?.serviceman?.isEmpty ?? false) {
      //   showAnimatedSnackBar(context, "No ServiceMan Available");
      // }
    } else {
      // print(response.statusCode);
      // print(response.body);
      // print('Something went wrong');
    }
  } on Exception catch (_) {}
}

searchServiceMan(
    BuildContext context, id, countryId, state, region, name, transport) async {
  final String lanId = Hive.box("LocalLan").get('lang_id');
  final servicerProvider =
      Provider.of<ServicerProvider>(context, listen: false);
  final provider = Provider.of<DataProvider>(context, listen: false);
  final userDetails = provider.viewProfileModel?.userdetails;
  // provider.subServicesModel = null;
  String? apiToken = Hive.box("token").get('api_token');
  // for explore apiToken want to be null so cant return it
  // if (apiToken == null) return;
  if (apiToken == null) {
    apiToken = '';
  }
  try {
    final url =
        '$servicemanList?service_id=$id&page=1&latitude=${servicerProvider.servicerLatitude ?? userDetails?.latitude ?? provider.explorerLat}&longitude=${servicerProvider.servicerLongitude ?? userDetails?.longitude ?? provider.explorerLong}&sel_country_id=${countryId ?? ''}&sel_state=${state ?? ''}&sel_region=${region ?? ''}&sel_name=${name ?? ''}&sel_transport=${transport ?? ''}&language_id=${lanId}';
    log(url);
    var response = await http.post(Uri.parse(url),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);

      final serviceManListData = ServiceManListModel.fromJson(jsonResponse);

      provider.getServiceManData(serviceManListData);
      // if (provider.serviceManListModel?.serviceman?.isEmpty ?? false) {
      //   showAnimatedSnackBar(context, "No ServiceMan Available");
      // }
    } else {
      // print(response.statusCode);
      // print(response.body);
      // print('Something went wrong');
    }
  } on Exception catch (_) {}
}

navToServiceMan(context, id, homeservice) {
  Navigator.pushReplacement(
      context,
      FadePageRoute(
          page: ServicerPage(
        id: id,
        homeservice: homeservice,
      )));
}
