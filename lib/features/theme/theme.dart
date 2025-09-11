import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.light(
  surfaceBright: Colors.grey.shade100,
  surfaceDim: Colors.grey.shade400,
  surface: Colors.grey.shade200,
  primary: Colors.grey.shade900,
  secondary: Colors.grey.shade300,
);

ThemeData lightMode = ThemeData.from(colorScheme: lightColorScheme).copyWith(
  textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Tajawal'),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
    ),
  ),
);

final ColorScheme darkColorScheme = ColorScheme.dark(
  surfaceBright: Colors.grey.shade800,
  surfaceDim: Colors.black,
  surface: Colors.grey.shade900,
  primary: Colors.grey.shade200,
  secondary: Colors.grey.shade400,
);

ThemeData darkMode = ThemeData.from(colorScheme: darkColorScheme).copyWith(
  textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Tajawal'),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkColorScheme.primary,
      foregroundColor: darkColorScheme.onPrimary,
    ),
  ),
);
