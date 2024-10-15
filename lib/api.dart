import 'dart:developer';

import 'package:dio/dio.dart';

class API {
  final Dio _dio = Dio();

  Future<Response> _sendPostRequest(String logText) async {
    const String apiEndpoint = "http://localhost:5000/api";
    const String apiRegisterEvent = "$apiEndpoint/register-event";

    try {
      log('Sending POST request: $logText');
      log('API endpoint: $apiRegisterEvent');
      Response response = await _dio.post(apiRegisterEvent, data: logText);
      log('Response: ${response.data}');
      return response;
    } catch (e) {
      log('Error sending POST request: $e');
      rethrow;
    }
  }

  // MFA
  Future<void> mfaEvent(bool value) async {
    await _sendPostRequest(
        'Multi-Factor Authentication is ${value ? 'enabled' : 'disabled'}');
  }

  Future<void> loginEvent(String username) async {
    await _sendPostRequest('User $username logged in');
  }

  Future<void> registerEvent(String username) async {
    await _sendPostRequest('User $username registered');
  }

  Future<void> logoutEvent(String username) async {
    await _sendPostRequest('User $username logged out');
  }
}
