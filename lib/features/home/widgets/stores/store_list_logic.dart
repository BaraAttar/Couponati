import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/app/config.dart';
import 'package:my_app/core/logger/logger_service.dart';

/// ===================== Store Model =====================
class StoreModel {
  final String id;
  final String name;
  final String? icon;

  StoreModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unnamed Store',
      icon: json['icon']?.toString() ?? '',
    );
  }
}

/// ===================== Store Controller =====================
class StoreController {
  /// Fetches the list of stores from API
  Future<List<StoreModel>> fetchStores() async {
    try {
      final uri = Uri.parse(AppConfig.getStores); // تأكد أن الرابط صحيح
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        // تحقق من وجود الحقل 'data'
        if (decoded['data'] != null && decoded['data'] is List) {
          final List<dynamic> data = decoded['data'];
          return data.map((json) => StoreModel.fromJson(json)).toList();
        } else {
          AppLogger.w('Warning: "data" field missing or not a list.');
          return [];
        }
      } else {
        AppLogger.e('Error: HTTP ${response.statusCode}');
        return [];
      }
    } catch (e) {
      AppLogger.e('Exception while fetching stores: $e');
      return [];
    }
  }
}
