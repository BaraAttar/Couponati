import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/app/config.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/core/storage/token_storage.dart';
import 'package:my_app/features/auth/auth_model.dart';

class AuthController extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  UserProfileModel? _user;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  UserProfileModel? get user => _user;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearErrors() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setUser(UserProfileModel user) {
    _user = user;
    notifyListeners();
  }

  _clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> signIn() async {
    try {
      _setLoading(true);
      _clearErrors();

      final account = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      await _sendToServer(account);
    } catch (error) {
      AppLogger.d('Unexpected error during sign in: $error');
      _setErrorMessage('حدث خطأ أثناء تسجيل الدخول');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _sendToServer(GoogleSignInAccount account) async {
    final idToken = account.authentication.idToken;

    if (idToken == null) {
      AppLogger.d('لم يتم الحصول على idToken');
      _setErrorMessage('فشل الحصول على رمز المصادقة');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(AppConfig.postAuth),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"idToken": idToken}),
      );

      if (response.statusCode != 200) {
        AppLogger.d('Server error: ${response.statusCode} - ${response.body}');
      }

      final decoded = jsonDecode(response.body);
      final controllerModel = AuthControllerModel.fromJson(decoded);

      final user = controllerModel.data?.user;
      if (user != null) {
        _setIsLoggedIn(true);
        _setUser(user);
      }
      await TokenStorage.saveToken(controllerModel.data!.token.toString());
      _setIsLoggedIn(true);

      AppLogger.d("Token saved:", controllerModel.data!.token.toString());
    } catch (e) {
      AppLogger.d('Server communication failed: $e');
      _setErrorMessage("Server communication failed");
    }
  }

  Future<void> checkIfLoggedIn() async {
    try {
      final token = await TokenStorage.getToken();

      if (token == null || token.isEmpty) {
        _setIsLoggedIn(false);
        return;
      }

      await verifyStoredToken(token);
    } catch (e) {
      AppLogger.d('خطأ في التحقق من حالة تسجيل الدخول: $e');
      _setIsLoggedIn(false);
    }
  }

  Future<void> verifyStoredToken(String? token) async {
    if (token == null) {
      AppLogger.d('لم يتم الحصول على token');
      _setErrorMessage('فشل الحصول على رمز المصادقة');
      _setIsLoggedIn(false);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(AppConfig.verifyToken),
        headers: {
          'Content-Type': 'application/json',
          "authorization": 'Bearer $token',
        },
      );

      final decoded = jsonDecode(response.body);
      final controllerModel = AuthControllerModel.fromJson(decoded);

      final user = controllerModel.data?.user;
      if (user != null) {
        _setUser(user);
       _setIsLoggedIn(true); 
    } else {
      _setIsLoggedIn(false);
    }
    } catch (e) {
      AppLogger.d('Server communication failed: $e');
      _setErrorMessage("Server communication failed");
    }
  }

  Future<void> signOut() async {
    try {
      await TokenStorage.deleteToken();
      await _googleSignIn.signOut();
      _setIsLoggedIn(false);
      _clearUser();
      _clearErrors();
      AppLogger.d("تم تسجيل الخروج بنجاح");
    } catch (e) {
      AppLogger.d("فشل تسجيل الخروج: $e");
      _setIsLoggedIn(false);
      _clearUser();
    }
  }
}
