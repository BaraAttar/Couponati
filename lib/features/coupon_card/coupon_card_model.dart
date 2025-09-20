// export interface Coupon extends Document {
//     _id: Types.ObjectId;
//     code: string;
//     discount: number;
//     usedCount?: number;
//     description?: string;
//     expiryDate?: Date;
//     active: boolean;
//     store: Types.ObjectId;
//     createdAt: Date;
//     updatedAt: Date;
// }

class CouponModel {
  final String id;
  final String code;
  final num discount;
  final String description;

  CouponModel({
    required this.id,
    required this.code,
    required this.discount,
    required this.description,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['_id']?.toString() ?? '',
      code: json['code']?.toString() ?? 'Unnamed Store',
      discount: json['discount'] ?? 0,
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'discount': discount,
      'description': description,
    };
  }
}
