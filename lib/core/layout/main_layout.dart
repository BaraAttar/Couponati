import 'package:flutter/material.dart';
import 'package:my_app/features/favourites/favourites_page.dart';
import 'package:my_app/features/settings/settings_page.dart';
import 'package:my_app/features/home/home_page.dart';
import 'package:my_app/core/layout/main_nav_bar.dart';

class Mainlayout extends StatefulWidget {
  const Mainlayout({super.key});

  @override
  State<Mainlayout> createState() => _MainlayoutState();
}

class _MainlayoutState extends State<Mainlayout> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    Favourites(),
    Settings(),
  ];

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // 👈 يسمح بامتداد تحت شريط النظام
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // الصفحات
          Positioned.fill(
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),

          // شريط التنقل مع البلور
          Align(
            alignment: Alignment.bottomCenter,
            child: MainNavBar(
              currentIndex: _currentIndex,
              onTap: _onTabSelected,
            ),
          ),
        ],
      ),
    );
  }
}
