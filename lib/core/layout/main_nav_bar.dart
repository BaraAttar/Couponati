// lib/core/layout/main_nav_bar.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/core/theme/theme_provider.dart';
import 'package:my_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class MainNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MainNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeProvider>(context).themeMode;

    final theme = Theme.of(context);
    final navBarColor = theme.colorScheme.surface.withValues(
      alpha: 0.7,
    ); // للـ Container
    final systemNavBarColor = theme.colorScheme.surface.withValues(
      alpha: 0.01,
    ); // لشريط النظام بدون شفافية

    // توحيد ألوان شريط النظام مع الخلفية
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: systemNavBarColor,
        // systemNavigationBarIconBrightness: Brightness.light ,
        systemNavigationBarIconBrightness:
        themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        statusBarColor: Colors.transparent,
        // statusBarIconBrightness: Brightness.dark 
        statusBarIconBrightness:
        themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        
      ),
    );

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: navBarColor, // شبه شفاف مع Blur
          child: _buildBottomNavigationBar(context, theme),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, ThemeData theme) {
    return Theme(
      data: theme.copyWith(
        splashFactory: NoSplash.splashFactory, // إزالة تأثير الماء
        highlightColor: Colors.transparent, // إزالة اللون عند الضغط
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent, // الشفافية من الـ Container
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: S.of(context).navbar_home),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: S.of(context).navbar_favourites,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: S.of(context).navbar_settings,
          ),
        ],
      ),
    );
  }
}
