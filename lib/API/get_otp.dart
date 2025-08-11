// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:tuw_services/API/endpoint.dart';
import 'package:tuw_services/components/routes_manager.dart';
import 'package:tuw_services/model/otp/get_otp.dart';
import 'package:tuw_services/providers/data_provider.dart';
import 'package:tuw_services/providers/otp_provider.dart';
import 'package:http/http.dart' as http;
import 'package:tuw_services/utils/animatedSnackBar.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:tuw_services/utils/network_utils.dart';
import 'package:tuw_services/utils/debug_utils.dart';
import 'package:tuw_services/utils/offline_mode.dart';

getOtp(
    {required BuildContext context,
    countryCode,
    phoneNo,
    resend,
    String? appSignature}) async {
  final String? id = Hive.box("LocalLan").get('lang_id');
  final String languageId = id ?? '1'; // Default to English (1) if no language is set
  
  try {
    // Check network connectivity first
    bool isConnected = await NetworkUtils.isConnected();
    if (!isConnected) {
      showAnimatedSnackBar(context, "No internet connection. Please check your network and try again.");
      return;
    }
    
    final provider = Provider.of<DataProvider>(context, listen: false);
    final otpProvider = Provider.of<OTPProvider>(context, listen: false);
    
    // Test if we can reach the server
    bool canReachServer = await NetworkUtils.canReachServer(endPoint);
    if (!canReachServer) {
      // Check if offline mode is enabled for testing
      if (OfflineMode.isOfflineMode) {
        log("Using offline mode for testing");
        var mockOtpData = OfflineMode.getMockOtpData();
        otpProvider.getOtpData(mockOtpData);
        
        if (resend == true) {
          showAnimatedSnackBar(context, "OTP sent successfully! (Offline Mode)", type: AnimatedSnackBarType.success);
          return;
        }
        
        navigateToOtp(context);
        return;
      }
      
      showAnimatedSnackBar(context, "Server is currently unavailable. Please try again later or contact support.");
      return;
    }
    
    StringBuffer urlsBuffer = StringBuffer(
        '$apiUser/request_otp?countrycode=$countryCode&phone=$phoneNo&language_id=$languageId');
    if (appSignature != null && Platform.isAndroid) {
      urlsBuffer.write('&signature_key=$appSignature');
    }
    final url = Uri.parse("$urlsBuffer");
    
    log("OTP API Request URL: $url");
    log("OTP API Request Headers: device-id: ${provider.deviceId ?? 'null'}");
    log("OTP API Request Parameters: countryCode=$countryCode, phoneNo=$phoneNo, languageId=$languageId");
    
    // Debug: Log network configuration
    DebugUtils.logNetworkInfo();
    
    // Try the request with retry logic
    http.Response? response;
    int retryCount = 0;
    const int maxRetries = 3;
    
    while (retryCount < maxRetries) {
      try {
        log("OTP API Attempt ${retryCount + 1} of $maxRetries");
        
        response = await http.post(
          url, 
          headers: {
            "device-id": provider.deviceId ?? '',
            "Content-Type": "application/json",
            "Accept": "application/json",
          }
        ).timeout(
          const Duration(seconds: 60), // Increased timeout to 60 seconds
          onTimeout: () {
            throw TimeoutException('Request timed out after 60 seconds');
          },
        );
        
        log("OTP API Response Status: ${response.statusCode}");
        log("OTP API Response Headers: ${response.headers}");
        log("OTP API Response Body: ${response.body}");
        
        // If we get a response, break out of retry loop
        break;
        
      } on TimeoutException catch (e) {
        retryCount++;
        log("OTP API Timeout on attempt $retryCount: $e");
        
        if (retryCount >= maxRetries) {
          throw Exception('Request timed out after $maxRetries attempts');
        }
        
        // Wait before retrying (exponential backoff)
        await Future.delayed(Duration(seconds: retryCount * 2));
        
      } on SocketException catch (e) {
        log("OTP API Socket Exception: $e");
        throw Exception('No internet connection. Please check your network and try again.');
        
      } on HttpException catch (e) {
        log("OTP API HTTP Exception: $e");
        throw Exception('HTTP error occurred. Please try again.');
        
      } catch (e) {
        log("OTP API Unexpected Error: $e");
        throw Exception('An unexpected error occurred. Please try again.');
      }
    }
    
    if (response == null) {
      throw Exception('Failed to get response after $maxRetries attempts');
    }
    
    if (response.statusCode != 200) {
      log("OTP API Error - Status Code: ${response.statusCode}");
      log("OTP API Error - Response Body: ${response.body}");
      
      // Try to parse error message from response
      try {
        var errorJson = jsonDecode(response.body);
        String errorMessage = "Server error (${response.statusCode}). Please try again later.";
        
        if (errorJson['message'] != null) {
          errorMessage = errorJson['message'].toString();
        }
        
        showAnimatedSnackBar(context, errorMessage);
      } catch (e) {
        showAnimatedSnackBar(context, "Server error (${response.statusCode}). Please try again later.");
      }
      return;
    }

    // Parse the response
    try {
      var jsonResponse = jsonDecode(response.body);
      log("OTP API JSON Response: $jsonResponse");
      
      final result = jsonResponse["result"];
      final action = jsonResponse["action"];
      log("OTP API Result: $result, Action: $action");

      if (result == false) {
        String errorMessage = "Failed to send OTP. Please try again.";
        
        try {
          if (jsonResponse["message"] != null) {
            if (jsonResponse["message"] is Map && jsonResponse["message"]["phone"] != null) {
              errorMessage = jsonResponse["message"]["phone"][0].toString();
            } else if (jsonResponse["message"] is String) {
              errorMessage = jsonResponse["message"];
            }
          }
        } catch (e) {
          log("Error parsing error message: $e");
        }
        
        showAnimatedSnackBar(context, errorMessage);
        return;
      }

      var getOtpData = GetOtp.fromJson(jsonResponse);
      log("OTP Data parsed successfully: ${getOtpData.toString()}");

      otpProvider.getOtpData(getOtpData);
      log("OTP Data stored in provider");

      if (resend == true) {
        log("This is a resend request, not navigating");
        showAnimatedSnackBar(context, "OTP sent successfully!", type: AnimatedSnackBarType.success);
        return;
      }
      
      log("About to navigate to OTP screen");
      navigateToOtp(context);
      
    } catch (e) {
      log("Error parsing OTP response: $e");
      showAnimatedSnackBar(context, "Error processing server response. Please try again.");
    }
    
  } on Exception catch (e) {
    log("OTP API Error: $e");
    print("OTP API Error: $e");
    
    // Handle specific error types
    if (e.toString().contains('timed out') || e.toString().contains('timeout')) {
      showAnimatedSnackBar(context, "Connection timed out. Please check your internet connection and try again.");
    } else if (e.toString().contains('SocketException') || e.toString().contains('No internet connection')) {
      showAnimatedSnackBar(context, "No internet connection. Please check your network and try again.");
    } else if (e.toString().contains('HTTP error')) {
      showAnimatedSnackBar(context, "Server connection error. Please try again.");
    } else {
      showAnimatedSnackBar(context, "Something went wrong. Please try again.");
    }
  }
}

navigateToOtp(context) {
  log("Navigating to OTP screen");
  print("Navigating to OTP screen");
  Navigator.pushNamed(context, Routes.otpScreen);
}
