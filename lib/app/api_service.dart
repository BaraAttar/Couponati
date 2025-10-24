import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/core/storage/token_storage.dart';

class ApiService {
  static Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Accept-Language': 'ar',
  };

  static void setLanguage(String langCode) {
    defaultHeaders['Accept-Language'] = langCode;
  }

  static Future<Map<String, String>> _getHeaders() async {
    try {
      final token = await TokenStorage.getToken();
      final headers = Map<String, String>.from(defaultHeaders);
      if (token != null && token.isNotEmpty) {
        headers['authorization'] = 'Bearer $token';
      }
      return headers;
    } catch (e) {
      AppLogger.e("Error getting headers: $e");
      return Map<String, String>.from(defaultHeaders);
    }
  }

  static Future<http.Response> get(String url) async {
    try {
      final uri = Uri.parse(url);
      final headers = await _getHeaders();
      AppLogger.d("GET $uri");
      
      return await http.get(uri, headers: headers).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timeout');
        },
      );
    } catch (e) {
      AppLogger.e("GET Error: $e");
      rethrow;
    }
  }

  static Future<http.Response> post(String url, dynamic body) async {
    try {
      final uri = Uri.parse(url);
      final headers = await _getHeaders();
      final encodedBody = jsonEncode(body);
      AppLogger.d("POST $uri\nBody: $encodedBody");
      
      return await http.post(
        uri, 
        headers: headers, 
        body: encodedBody,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timeout');
        },
      );
    } catch (e) {
      AppLogger.e("POST Error: $e");
      rethrow;
    }
  }

  static Future<http.Response> put(String url, dynamic body) async {
    try {
      final uri = Uri.parse(url);
      final headers = await _getHeaders();
      final encodedBody = jsonEncode(body);
      AppLogger.d("PUT $uri\nBody: $encodedBody");
      
      return await http.put(
        uri, 
        headers: headers, 
        body: encodedBody,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timeout');
        },
      );
    } catch (e) {
      AppLogger.e("PUT Error: $e");
      rethrow;
    }
  }

  static Future<http.Response> delete(String url) async {
    try {
      final uri = Uri.parse(url);
      final headers = await _getHeaders();
      AppLogger.d("DELETE $uri");
      
      return await http.delete(uri, headers: headers).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timeout');
        },
      );
    } catch (e) {
      AppLogger.e("DELETE Error: $e");
      rethrow;
    }
  }
}