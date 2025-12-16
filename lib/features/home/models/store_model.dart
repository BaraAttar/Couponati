// lib/features/home/widgets/stores/store_model.dart
import 'package:my_app/features/store_screen/models/coupon_model.dart';

class StoreModel {
  final String id;
  final String name;
  final String icon;
  final String description;
  final List<CouponModel> coupon;

  StoreModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    List<CouponModel>? coupon,
  }) : coupon = coupon ?? [];

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    final couponsJson = (json['coupons'] ?? json['coupon']) as List<dynamic>? ?? [];
    final coupons = couponsJson.map((c) => CouponModel.fromJson(c)).toList();

    return StoreModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unnamed Store',
      icon: json['icon']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      coupon: coupons,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'icon': icon,
      'description': description,
      'coupons': coupon.map((c) => c.toJson()).toList(),
    };
  }
}


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
