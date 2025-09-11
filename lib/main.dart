import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 👈 مهم!
import 'package:my_app/features/main_pages/main_layout.dart';
import 'package:my_app/features/theme/theme.dart';
import 'package:my_app/features/theme/theme.provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Mainlayout(),
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,

          // 👇 دعم الترجمة والاتجاه RTL
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          locale: const Locale('ar'), // 👈 التطبيق كله سيكون RTL + عربي
        );
      },
    );
  }
}