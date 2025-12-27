import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/app/api_service.dart';
import 'package:my_app/app/config.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/features/home/models/category_model.dart';
import 'package:my_app/generated/l10n.dart';

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
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      _setLoading(true);

      final uri = Uri.parse(AppConfig.getCategories);
      final response = await ApiService.get(uri);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final controllerModel = CategoriesControllerModel.fromJson(decoded);

        // إضافة فئة "الكل" في البداية (مترجمة بحسب لغة التطبيق)
        _categories = [
          CategoryModel(id: 'all', name: S.current.categories_all, order: 0, icon: "all"),
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
