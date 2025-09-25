// lib/features/home/widgets/stores/store_controller_model.dart
import 'store_model.dart';

class StoreControllerModel {
  final List<StoreModel> data;
  final int totalCount;
  final int remaining;
  final int pageCount;
  final bool success;
  final String message;

  StoreControllerModel({
    required this.data,
    required this.totalCount,
    required this.remaining,
    required this.pageCount,
    required this.success,
    required this.message,
  });

  factory StoreControllerModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataJson = json['data'] ?? [];
    final dataList = dataJson.map((e) => StoreModel.fromJson(e)).toList();

    return StoreControllerModel(
      data: dataList,
      totalCount: json['totalCount'] ?? 0,
      remaining: json['remaining'] ?? 0,
      pageCount: json['pageCount'] ?? dataList.length,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'totalCount': totalCount,
      'remaining': remaining,
      'pageCount': pageCount,
      'success': success,
      'message': message,
    };
  }
}
