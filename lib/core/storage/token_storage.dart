import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static final _storage = FlutterSecureStorage();
  static const _key = 'token';

  // حفظ التوكن
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  // قراءة التوكن
  static Future<String?> getToken() async {
    return await _storage.read(key: _key);
  }

static Future<Map<String, String>> getAll() async {
    return await _storage.readAll();
  }

  // حذف التوكن
  static Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }
}
