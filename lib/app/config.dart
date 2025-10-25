// lib/app/config.dart
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // static const String baseUrl = "http://10.0.2.2:3000";
  static const String baseUrl = "http://localhost:3000";
  // static const String baseUrl = "https://couponati-api.onrender.com";

  // static String baseUrl = dotenv.env['BASE_URL'] ?? "http://localhost:3000";

  static String get postAuth => "$baseUrl/auth/google/token";
  static String get verifyToken => "$baseUrl/auth/verifyToken";
  static String get getCoupon => "$baseUrl/coupon";
  static String get getBanners => "$baseUrl/banner";
  static String get getStores => "$baseUrl/store";
  static String get getCategories => "$baseUrl/category";
  static String get userFavourites => "$baseUrl/user/store/favourites";
}
