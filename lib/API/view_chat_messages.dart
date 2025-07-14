// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/view_chat_message_model.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/utils/initPlatformState.dart';

Future<void> viewChatMessages(BuildContext context, dynamic id,
    {int page = 1}) async {
  log("view message api calling");
  print(page);
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  try {
    int lastPage = provider.viewChatMessageModel?.chatMessage?.lastPage ?? 1;
    log('lastPage--$lastPage------$page');
    if (lastPage < page) return;
    var response = await http.post(
        Uri.parse('$viewChatMessagesApi$id&page=$page'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    log('viewChatMessages-->> ${response.body}-----_${response.request}');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      bool isLogOut =
          jsonResponse["message"].toString().contains("Please login again");
      if (isLogOut) {
        showAnimatedSnackBar(context, "Please login again");
        initPlatformState(context);
      } else {
        final viewChatMessageData = ViewChatMessageModel.fromJson(jsonResponse);
        if (page == 1) {
          provider.viewChatMessageModelData(viewChatMessageData);
        } else {
          provider
              .appendChatMessages(viewChatMessageData.chatMessage?.data ?? []);
        }
      }
    } else {
      // Handle error
    }
  } on Exception catch (e) {
    log("Something Went Wrong18");
    print(e);
  }
}
