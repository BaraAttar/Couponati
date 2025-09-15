import 'package:flutter/material.dart';
import 'package:my_app/core/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark;

  bool get isDark => _isDark;

    ColorScheme get colorScheme => _isDark ? darkColorScheme : lightColorScheme;


  ThemeProvider() : _isDark = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark {
    // الاستماع لتغير ثيم الجهاز
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      _isDark = brightness == Brightness.dark;
      notifyListeners();
    };
  }

  // تبديل يدوي للثيم داخل التطبيق
  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
