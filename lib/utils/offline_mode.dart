import 'package:tuw_services/model/otp/get_otp.dart';

class OfflineMode {
  static bool isOfflineMode = false;
  
  static void enableOfflineMode() {
    isOfflineMode = true;
  }
  
  static void disableOfflineMode() {
    isOfflineMode = false;
  }
  
  static GetOtp getMockOtpData() {
    return GetOtp(
      result: true,
      message: "OTP sent successfully",
      oTP: 123456, // Mock OTP for testing
    );
  }
  
  static String getMockErrorMessage() {
    return "Server is currently unavailable. Using offline mode for testing.";
  }
} 