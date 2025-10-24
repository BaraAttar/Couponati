import 'package:flutter/material.dart';
import 'package:my_app/app/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('languageCode') ?? 'ar';
    _locale = Locale(lang);
    ApiService.setLanguage(lang);
    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', newLocale.languageCode);
    ApiService.setLanguage(newLocale.languageCode);
  }
}
