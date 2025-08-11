import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkUtils {
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<bool> canReachServer(String baseUrl) async {
    try {
      final response = await http.get(Uri.parse(baseUrl)).timeout(
        const Duration(seconds: 10),
      );
      return response.statusCode == 200 || response.statusCode == 404; // 404 means server is reachable
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> testApiEndpoint(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(endpoint)).timeout(
        const Duration(seconds: 15),
      );
      
      return {
        'success': true,
        'statusCode': response.statusCode,
        'responseTime': DateTime.now().millisecondsSinceEpoch,
        'body': response.body.substring(0, response.body.length > 200 ? 200 : response.body.length),
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    }
  }
} 