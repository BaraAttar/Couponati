import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_app/app/config.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/features/home/widgets/banner/banner_model.dart';

class BannerController extends ChangeNotifier {
  List<BannerModel> _banners = [];
  bool _isLoading = false;
  bool? _success;

  List<BannerModel> get banners => _banners;
  bool get isLoading => _isLoading;
  bool? get success => _success;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setSuccess(bool value) {
    _success = value;
    notifyListeners();
  }

  Future<void> fetchBanners() async {
    _setLoading(true);

    try {
      final response = await http.get(Uri.parse(AppConfig.getBanners));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final controllerModel = BannerControllerModel.fromJson(decoded);

        _banners = controllerModel.data;

        _setSuccess(true);

        // AppLogger.d('Banners success: ${controllerModel.data.length}');
      } else {
        _banners = [];
        _setSuccess(false);
      }
    } catch (e) {
        AppLogger.d('Banners error: ${e.toString()}');
      _banners = [];
      _setSuccess(false);
    } finally {
      _setLoading(false);
    }
  }
}
