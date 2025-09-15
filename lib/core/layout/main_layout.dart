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

  final List<Widget> _pages = [
    HomePage(),
    const Favourites(),
    const Settings(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MainNavBar(
              currentIndex: _currentIndex,
              onTap: _onTabSelected,
            ),
          ),
        ],
      ),
      // body: _pages[_currentIndex],
      // bottomNavigationBar: MainNavBar(
      //   currentIndex: _currentIndex,
      //   onTap: _onTabSelected,
      // ),
    );
  }
}
