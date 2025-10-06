// lib/app/config.dart
class AppConfig {
  static const String baseUrl = "http://localhost:3000";
  // static const String baseUrl = "https://couponati-api.onrender.com";

  static const String postAuth = "$baseUrl/auth/google/token";
  static const String verifyToken = "$baseUrl/auth/verifyToken";
  static const String getCoupon = "$baseUrl/coupon";
  static const String getBanners = "$baseUrl/banner";
  static const String getStores = "$baseUrl/store";
  static const String getCategories = "$baseUrl/category";
}
