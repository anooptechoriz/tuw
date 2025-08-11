import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tuw_services/API/endpoint.dart';

class DebugUtils {
  static Future<void> testApiEndpoints() async {
    log("=== API Endpoint Debug Test ===");
    
    // Test base endpoint
    await _testEndpoint("Base Endpoint", endPoint);
    
    // Test API endpoint
    await _testEndpoint("API Endpoint", api);
    
    // Test user API endpoint
    await _testEndpoint("User API Endpoint", apiUser);
    
    // Test specific OTP endpoint
    String otpUrl = "$apiUser/request_otp?countrycode=968&phone=123456789&language_id=1";
    await _testEndpoint("OTP Endpoint", otpUrl);
  }
  
  static Future<void> _testEndpoint(String name, String url) async {
    try {
      log("Testing $name: $url");
      
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );
      
      log("$name - Status: ${response.statusCode}");
      log("$name - Headers: ${response.headers}");
      
      if (response.body.length > 500) {
        log("$name - Body (first 500 chars): ${response.body.substring(0, 500)}...");
      } else {
        log("$name - Body: ${response.body}");
      }
      
    } catch (e) {
      log("$name - Error: $e");
    }
    
    log("---");
  }
  
  static void logNetworkInfo() {
    log("=== Network Configuration ===");
    log("Base Endpoint: $endPoint");
    log("API Endpoint: $api");
    log("User API Endpoint: $apiUser");
    log("========================");
  }
} 