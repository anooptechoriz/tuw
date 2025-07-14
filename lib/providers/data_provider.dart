import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_services/constants/constant.dart';
import 'package:social_media_services/model/active_services.dart' as s;
import 'package:social_media_services/model/active_subscription.dart';
import 'package:social_media_services/model/chat_list.dart';
import 'package:social_media_services/model/favorite_serviceMan.dart';
import 'package:social_media_services/model/getCoupenModel.dart';
import 'package:social_media_services/model/get_child_service.dart';
import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/model/get_home.dart';
import 'package:social_media_services/model/get_language.dart';
import 'package:social_media_services/model/other%20User/other_user_address_model.dart';
import 'package:social_media_services/model/other%20User/other_user_profile_model.dart';
import 'package:social_media_services/model/other%20User/show_user_address.dart';
import 'package:social_media_services/model/payment_success.dart';
import 'package:social_media_services/model/place_order.dart';
import 'package:social_media_services/model/region_info_model.dart';
import 'package:social_media_services/model/serviceManLIst.dart';
import 'package:social_media_services/model/serviceman_profile_model.dart';
import 'package:social_media_services/model/state_info_model.dart';
import 'package:social_media_services/model/sub_services_model.dart';
import 'package:social_media_services/model/user_address_show.dart';
import 'package:social_media_services/model/viewProfileModel.dart';
import 'package:social_media_services/model/view_chat_message_model.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  bool isLoading = false;
  LanguageModel? languageModel;
  RegionInfo? regionInfoModel;
  Stateinfo? stateinfomodel;
  Timer? timer;
  String? explorerLat;
  String? explorerLong;
  String? fileName;
  List<Services> sGroup = [];

  Future<FilePickerResult?> pickFiles() async {
    isLoading = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'jpg',
        'png',
        'jpeg',
      ],
    );
    isLoading = false;
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }

  final ImagePicker picker = ImagePicker();

  Future<XFile?> openCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 200,
      maxWidth: 1000,

      // maxWidth: maxWidth,
      // maxHeight: maxHeight,
      // imageQuality: quality,
    );
    if (xFile != null) {
      return xFile;
    } 
    return null;
  }

  onChangeFileName({required Document item, required String fileName}) {
    item.fileName = fileName;
    notifyListeners();
  }

  void cancelTimer() {
    timer?.cancel();
  }

  void languageModelData(value) {
    languageModel = value;
    notifyListeners();
  }

  void regionInfodata(value) {
    regionInfoModel = value;
    notifyListeners();
  }

  void stateinfodata(value) {
    stateinfomodel = value;
    notifyListeners();
  }

  void clearRegions() {
    regionInfoModel = null;
  }

  void clearStates() {
    stateinfomodel = null;
  }
void clearDocs(){
  customerChildSer?.documents?.clear();
  notifyListeners();
}
  CountriesModel? countriesModel;

  void countriesModelData(value) {
    countriesModel = value;
    notifyListeners();
  }

  String? deviceId;

  ViewProfileModel? viewProfileModel;

  void viewProfileData(value) {
    viewProfileModel = value;
    notifyListeners();
  }

  HomeModel? homeModel;

  void homeModelData(value) {
    homeModel = value;
    notifyListeners();
  }

  HomeModel? customerParentSer;

  void parentModelData(value) {
    customerParentSer = value;
    notifyListeners();
  }

  ChildServiceModel? customerChildSer;

  void childModelData(value) {
    customerChildSer = value;
     List<Document> documents = customerChildSer?.documents ?? [];
  //  for(var item in documents){
  //   // item.id = (item.id??0)+1;
  //   customerChildSer?.documents?.add(item);
  //  }
log('item?.documents -->> ${documents.length}');
    notifyListeners();
  }

  GetCoupenModel? coupenCodeModel;

  void coupenCodeData(value) {
    coupenCodeModel = value;
    notifyListeners();
  }

  SubServicesModel? subServicesModel;

  void subServicesModelData(value) {
    subServicesModel = value;
    log('subServicesModel--------${subServicesModel?.message}');
    notifyListeners();
  }

  OtherUserProfile? otherUserProfile;

  void getOtherUserProfileData(value) {
    otherUserProfile = value;
    notifyListeners();
  }

  ActiveSubscription? activeSubscription;

  void getActiveSubscriptionData(value) {
    activeSubscription = value;
    notifyListeners();
  }

  s.ActiveServices? activeServices;

  void getActiveServicesData(value) {
    activeServices = value;
    notifyListeners();
  }

  OtherUserAddress? otherUserAddress;

  void getOtherUserAddressData(value) {
    otherUserAddress = value;
    notifyListeners();
  }

  ViewChatMessageModel? viewChatMessageModel;

  void viewChatMessageModelData(value) {
    viewChatMessageModel = value;
    notifyListeners();
  }

  PlaceOrder? placeOrder;

  void getPlaceOrderData(value) {
    placeOrder = value;
    notifyListeners();
  }

  PaymentSuccessModel? paymentSuccess;

  void getPaymentSuccessData(value) {
    paymentSuccess = value;
    notifyListeners();
  }

  UserAddressShow? userAddressShow;

  void getUserAddressData(value) {
    userAddressShow = value;
    notifyListeners();
  }

  ShowUserAddress? pUserAddressShow;

  void getUserAddressShowData(value) {
    pUserAddressShow = value;
    notifyListeners();
  }

  ServiceManListModel? serviceManListModel;

  void getServiceManData(value) {
    serviceManListModel = value;
    notifyListeners();
  }

  FavoriteServiceManModel? serviceManListFavoriteModel;

  void getServiceManFavoriteData(value) {
    serviceManListFavoriteModel = value;
    notifyListeners();
  }

  ServiceManProfile? serviceManProfile;

  void getServiceManProfileData(value) {
    serviceManProfile = value;
    notifyListeners();
  }

  ServiceManProfile? serviceManDetails;

  void getServiceManDetails(value) {
    serviceManDetails = value;
    notifyListeners();
  }

  ChatListModel? chatListDetails;

  void getChatListDetails(value) {
    chatListDetails = value;
    notifyListeners();
  }

  // bool isInternetConnected = false;
  bool isTwoWheelerSelected = false;
  bool isFourWheelerSelected = false;

  bool isTwoSelected = false;
  bool isLocationSending = false;
  bool isSendingSuccessFull = false;

  String? servicerSelectedCountry;
  String? servicerSelectedReg;

  String gender = 'male';
  int? serviceId;
  int? selectedCountryId;
  int? selectedRegid;
  int? packageId;
  int? packageAmount;

  double? addressLatitude;
  double? addressLongitude;
  String? locality;

  XFile? image;
  Countries? selectedAddressCountry;
  XFile? sendImage;
  XFile? pickedFile;
  // String country
  // chat list
  //
  void appendChatMessages(List<ChatData> newMessages) {
    viewChatMessageModel?.chatMessage?.data?.addAll(newMessages);
    notifyListeners();
  }

  // late PagingController<int, ChatModel> chatListController;
  // int currentPage = 0;
  // initChatListPagination(
  //     {required BuildContext context, required String userID}) {
  //   currentPage = 0;
  //   chatListController = PagingController(firstPageKey: 1);
  //   chatListController.addPageRequestListener((pageKey) {
  //     getChatList(page: pageKey, userID: userID, context: context);
  //   });
  // }

  // Future<void> getChatList(
  //     {required int page,
  //     required String userID,
  //     required BuildContext context}) async {
  //   final apiToken = Hive.box("token").get('api_token');
  //   if (apiToken == null) return;
  //   if (currentPage != page) {
  //     currentPage = page;
  //     final apiToken = Hive.box("token").get('api_token');
  //     var response = await http.post(
  //       Uri.parse('$viewChatMessagesApi$userID&page=$page&limit=25'),
  //       headers: {"device-id": deviceId ?? '', "api-token": apiToken},
  //     );
  //     var jsonResponse = jsonDecode(response.body);
  //     log('getChatList--with-pagination-->>>' + jsonEncode(jsonResponse));

  //     if (response.statusCode == 200) {
  //       bool isLogOut =
  //           jsonResponse["message"].toString().contains("Please login again");
  //       if (isLogOut) {
  //         initPlatformState(context);
  //       }
  //       Map<String, dynamic> data = jsonDecode(response.body);
  //       Map<String, dynamic> chatMessage = data['chat_message'];
  //       List chatList = chatMessage['data'];
  //       List<ChatModel> temp =
  //           chatList.map((e) => ChatModel.fromJson(e)).toList();
  //       if (data['next_page_url'] != null) {
  //         chatListController.appendPage(temp, page + 1);
  //       } else {
  //         chatListController.appendLastPage(temp);
  //       }
  //     } else {
  //       chatListController.appendLastPage([]);
  //     }
  //   }
  // }

  sendNotification() async {
    print("send notification button pressed");
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAATC8MqX8:APA91bG87nhxF74WYDXYNJ55l7zzQ00ivrvqlSaYz9KpTS2RUvk0Uct2QwturSILbgQkLdE1VN2HnixA0xLeKiVNBYZSLPZJC0pHPpJVNd7TuNnwGVgJA1BumPq4CqeRpYnE1vJQCl5M',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'this is a body',
              'title': 'this is a title',
              "content_available": true
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': fcmToken,
          },
        ),
      );
      log('sendNotification--${response.body}--fcm--  $fcmToken');
      if (response.statusCode == 200) {
        // print("SENT NOTIFICATION TO THE DEVICE :$token");
        // Fluttertoast.showToast(msg: "SENT NOTIFICATION TO THE DEVICE :$token");
      } else {
        print("error push notification");
        // Fluttertoast.showToast(msg: "error push notification");
      }
    } catch (e) {
      print("error push notification");
    }
  }
}
