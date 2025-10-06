import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/features/home/models/store_model.dart';
import 'package:my_app/app/config.dart';

class SearchBarController extends ChangeNotifier {
  late List<StoreModel> _list = [];
  bool _isLoading = false;
  bool? _success;

  List<StoreModel> get list => _list;
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

  Future<void> fetchStoresByName(String query) async {
    _setLoading(true);

    final queryParameters = {'name': query.toString()};

    final uri = Uri.parse(
      AppConfig.getStores,
    ).replace(queryParameters: queryParameters);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final storeControllerModel = StoreControllerModel.fromJson(decoded);

        _list = storeControllerModel.data;
        _setSuccess(true);
        AppLogger.d('Search bar success : ${storeControllerModel.data.length}');
      } else {
        _list = [];
        _setSuccess(false);
      }
    } catch (e) {
      _list = [];
      AppLogger.d(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}
