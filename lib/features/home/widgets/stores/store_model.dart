// lib/features/home/widgets/stores/store_model.dart
import 'package:my_app/features/coupon_card/coupon_model.dart';

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
    final couponsJson = json['coupons'] as List<dynamic>? ?? [];
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
