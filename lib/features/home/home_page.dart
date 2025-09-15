import 'package:flutter/material.dart';
import 'package:my_app/features/home/widgets/banners/banners_slider.dart';
import 'package:my_app/features/home/widgets/categories/categories_slider.dart';
import 'package:my_app/features/home/widgets/search_bar/search_bar.dart';
import 'package:my_app/features/home/widgets/stores/stores_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 120), // مكان الـ Header
              ),
              SliverToBoxAdapter(child: BannerSlider()),
              SliverToBoxAdapter(child: CategoriesSlider()),
              StoresList()
            ],
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(),
          ),
        ],
      ),
    );
  }
}
