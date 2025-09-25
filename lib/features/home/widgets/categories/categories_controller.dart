import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/app/config.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/features/home/widgets/categories/category_model.dart';
import 'package:http/http.dart' as http;

class CategoriesController extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  bool? _success;
  String? _selectedCategoryId;

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  bool? get success => _success;
  String get selectedCategoryId => _selectedCategoryId ?? 'all';

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setSuccess(bool value) {
    _success = value;
    notifyListeners();
  }

  void setSelectedCategoryId(String id) {
    _selectedCategoryId = id;
    // AppLogger.d("************** selectedCategoryId: $_selectedCategoryId");
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse(AppConfig.getCategories));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final controllerModel = CategoriesControllerModel.fromJson(decoded);

        // إضافة فئة "الكل" في البداية
        _categories = [
          CategoryModel(id: 'all', name: 'الكل', order: 0, icon: null),
          ...controllerModel.data,
        ];

        _selectedCategoryId ??= 'all';
        _setSuccess(true);
      } else {
        _categories = [];
      }
    } catch (e) {
      _categories = [];
      _setSuccess(false);
      AppLogger.e('Error fetching categories: $e');
    } finally {
      _setLoading(false);
    }
  }
}
