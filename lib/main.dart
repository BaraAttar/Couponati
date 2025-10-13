// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_app/core/layout/main_layout.dart';
import 'package:my_app/core/locale/locale_provider.dart';
import 'package:my_app/core/theme/theme.dart';
import 'package:my_app/core/theme/theme_provider.dart';
import 'package:my_app/features/auth/auth_controller.dart';
import 'package:my_app/features/favourites/favourites_controller.dart';
import 'package:provider/provider.dart';

// TODO: add Localization files [ar-en]
void main() async {
  // Enables edge-to-edge mode so the app extends under system bars
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final favouritesController = FavouritesController();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => favouritesController),
        ChangeNotifierProvider(
          create: (_) =>
              AuthController(favouritesController)..checkIfLoggedIn(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Mainlayout(),
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeProvider.themeMode,
          locale: localeProvider.locale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar'), Locale('en')],
        );
      },
    );
  }
}
