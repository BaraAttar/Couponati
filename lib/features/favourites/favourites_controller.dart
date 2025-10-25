import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/app/api_service.dart';
import 'package:my_app/app/config.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/core/storage/token_storage.dart';
import 'package:my_app/features/home/models/store_model.dart';
import 'package:my_app/generated/l10n.dart';

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
    try {
      final token = await TokenStorage.getToken();
      if (token == null) {
        _setErrorMessage(S.current.favourites_login_required);
        return;
      }

      _setLoading(true);

      final uri = Uri.parse(AppConfig.userFavourites);
      final response = await ApiService.get(uri);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body is List) {
          _favourites = body
              .map((e) => StoreModel.fromJson(e))
              .toList(growable: true);
        } else if (body is Map && body['data'] is List) {
          _favourites = (body['data'] as List)
              .map((e) => StoreModel.fromJson(e))
              .toList(growable: true);
        }
        _setErrorMessage(null);
      } else {
        _setErrorMessage(
          '${S.current.favourites_load_failed} (${response.statusCode})',
        );
      }
    } catch (e) {
      AppLogger.e('خطأ في تحميل المفضلة: $e');
      _setErrorMessage(S.current.favourites_connection_error);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleFavourite(StoreModel store) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      _setErrorMessage(S.current.favourites_login_required);
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
      // final response = isCurrentlyFavourite
      //     ? await http.delete(
      //         Uri.parse('${AppConfig.userFavourites}/${store.id}'),
      //         headers: {'Authorization': 'Bearer $token'},
      //       )
      //     : await http.post(
      //         endpoint,
      //         headers: {
      //           'Content-Type': 'application/json',
      //           'Authorization': 'Bearer $token',
      //         },
      //         body: jsonEncode({'storeId': store.id}),
      //       );
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
        _setErrorMessage(
          '${S.current.favourites_update_failed} (${response.statusCode})',
        );
      }
    } catch (e) {
      if (isCurrentlyFavourite) {
        _favourites.add(store);
      } else {
        _favourites.removeWhere((s) => s.id == store.id);
      }
      notifyListeners();
      AppLogger.e('خطأ في تحديث المفضلة: $e');
      _setErrorMessage(S.current.favourites_connection_error);
    }
  }
}
