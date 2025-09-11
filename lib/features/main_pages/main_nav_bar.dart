import 'dart:ui';
import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.7), // خلفية بيضاء شبه شفافة
          ),
          child: _buildNavBarWidget(context),
        ),
      ),
    );
  }

  Widget _buildNavBarWidget(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        splashFactory: NoSplash.splashFactory, // إزالة تأثير الماء
        highlightColor: Colors.transparent,    // إزالة اللون عند الضغط
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent, // خليناه شفاف لأنه عندنا Container فوق
        elevation: 0, // إزالة الظل الافتراضي
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'),
        ],
      ),
    );
  }
}
