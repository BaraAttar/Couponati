import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/app/config.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/core/storage/token_storage.dart';
import 'package:my_app/features/home/models/store_model.dart';

class FavouritesController extends ChangeNotifier {
  List<StoreModel> _favourites = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<StoreModel> get favourites => _favourites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  void _setErrorMessage(String? message) {
    if (_errorMessage != message) {
      _errorMessage = message;
      _setLoading(false);
      notifyListeners();
    }
  }

  bool isFavourite(String storeId) {
    return _favourites.any((store) => store.id == storeId);
  }

  void setFavouritesFromAuth(List<StoreModel> favourites) {

    // for (int i = 0; i < favourites.length; i++) {
    //   final store = favourites[i];
    //   AppLogger.d(
    //     '📦 متجر #${i + 1}:\n'
    //     '   ├─ ID: ${store.id}\n'
    //     '   ├─ Name: ${store.name}\n'
    //     '   ├─ Icon: ${store.icon}\n'
    //     '   ├─ Description: ${store.description}\n'
    //     '   └─ عدد الكوبونات: ${store.coupon.length}',
    //   );
      
    //   // طباعة تفاصيل الكوبونات
    //   if (store.coupon.isNotEmpty) {
    //     for (int j = 0; j < store.coupon.length; j++) {
    //       final coupon = store.coupon[j];
    //       AppLogger.d(
    //         '      🎟️  كوبون #${j + 1}:\n'
    //         '         ├─ Code: ${coupon.code}\n'
    //         '         ├─ Discount: ${coupon.discount}%\n'
    //         '         └─ Description: ${coupon.description}',
    //       );
    //     }
    //   } else {
    //     // AppLogger.w('      ⚠️  لا توجد كوبونات في هذا المتجر!');
    //   }
    // }

    // AppLogger.i(
    //   'FavouritesController: استقبلت قائمة المفضلة من المصادقة (${favourites.length} عنصر)',
    // );
    _favourites = favourites;
    _setErrorMessage(null);
    _setLoading(false);
    notifyListeners();
  }

  void clearFavourites() {
    AppLogger.i('FavouritesController: جاري تفريغ قائمة المفضلة');
    _favourites.clear();
    _setErrorMessage(null);
    notifyListeners();
  }

  Future<void> fetchFavourites() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      _setErrorMessage('يجب تسجيل الدخول أولاً');
      return;
    }

    _setLoading(true);

    try {
      final response = await http.get(
        Uri.parse(AppConfig.userFavourites),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        _favourites = data
            .map((e) => StoreModel.fromJson(e))
            .toList(growable: true);
        _setErrorMessage(null);
      } else {
        _setErrorMessage('فشل تحميل المفضلة (${response.statusCode})');
      }
    } catch (e) {
      AppLogger.e('خطأ في تحميل المفضلة: $e');
      _setErrorMessage('مشكلة في الاتصال');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleFavourite(StoreModel store) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      _setErrorMessage('يجب تسجيل الدخول أولاً');
      return;
    }

    final isCurrentlyFavourite = isFavourite(store.id);
    final endpoint = Uri.parse(AppConfig.userFavourites);

    if (isCurrentlyFavourite) {
      _favourites.removeWhere((s) => s.id == store.id);
    } else {
      _favourites.add(store);
    }
    notifyListeners();

    try {
      final response = isCurrentlyFavourite
          ? await http.delete(
              Uri.parse('${AppConfig.userFavourites}/${store.id}'),
              headers: {'Authorization': 'Bearer $token'},
            )
          : await http.post(
              endpoint,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({'storeId': store.id}),
            );

      if (response.statusCode != 200) {
      // لو فشل السيرفر، ارجع الحالة السابقة
      if (isCurrentlyFavourite) {
        _favourites.add(store);
      } else {
        _favourites.removeWhere((s) => s.id == store.id);
      }
      notifyListeners();
      AppLogger.e(
        'فشل تحديث المفضلة: ${response.statusCode} - ${response.body}',
      );
      _setErrorMessage('فشل التحديث (${response.statusCode})');
    }
    } catch (e) {
       if (isCurrentlyFavourite) {
      _favourites.add(store);
    } else {
      _favourites.removeWhere((s) => s.id == store.id);
    }
      notifyListeners();
      AppLogger.e('خطأ في تحديث المفضلة: $e');
      _setErrorMessage('مشكلة في الاتصال');
    }
  }
}
