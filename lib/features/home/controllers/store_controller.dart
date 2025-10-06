// lib/features/home/widgets/stores/store_controller.dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/app/config.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/features/home/models/store_model.dart';

class StoreController {
  /// Fetches the list of stores from API
  Future<StoreControllerModel> fetchStores({
    int page = 1,
    String? categoryId,
  }) async {
    try {
      final queryParameters = {'page': page.toString()};
      if (categoryId != null && categoryId != 'all') {
        queryParameters['category'] = categoryId;
      }

      final uri = Uri.parse(
        AppConfig.getStores,
      ).replace(queryParameters: queryParameters);

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              throw TimeoutException('Request timed out');
            },
          );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return StoreControllerModel.fromJson(decoded);
      } else {
        AppLogger.d('Error: HTTP ${response.statusCode}');
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      AppLogger.d('Exception while fetching stores: $e');
      rethrow;
    }
  }
}
