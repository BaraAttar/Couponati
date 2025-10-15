// lib/features/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:my_app/features/home/widgets/banner_slider_view.dart';
import 'package:my_app/features/home/controllers/categories_controller.dart';
import 'package:my_app/features/home/widgets/categories_view.dart';
import 'package:my_app/features/home/widgets/header.dart';
import 'package:my_app/features/home/widgets/stores_list_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  // GlobalKeys للوصول إلى state الـ widgets
  final GlobalKey<BannerSliderViewState> _bannersKey =
      GlobalKey<BannerSliderViewState>();
  final GlobalKey<CategoriesSliderState> _categoriesKey =
      GlobalKey<CategoriesSliderState>();
  final GlobalKey<StoresListViewState> _storesKey =
      GlobalKey<StoresListViewState>();

  @override
  bool get wantKeepAlive => true; // 👈 هذا يحافظ على الحالة

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ChangeNotifierProvider(
      create: (_) => CategoriesController()..fetchCategories(),
      child: Consumer<CategoriesController>(
        builder: (context, categoriesController, _) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surfaceDim,
            body: Stack(
              children: [
                RefreshIndicator(
                  displacement: 160,
                  onRefresh: _onRefresh,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 80), // مكان الـ Header
                      ),
                      SliverToBoxAdapter(
                        child: BannerSliderView(key: _bannersKey),
                      ),
                      SliverToBoxAdapter(
                        child: CategoriesSlider(
                          key: _categoriesKey,
                          onCategorySelected: (id) {
                            categoriesController.setSelectedCategoryId(id);
                            _storesKey.currentState?.refreshStores(
                              categoryId: id,
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(child: const SizedBox(height: 16)),
                      StoresListView(
                        key: _storesKey,
                        controller: _scrollController,
                      ),
                    ],
                  ),
                ),
                const Positioned(top: 0, left: 0, right: 0, child: Header()),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 200));

    _bannersKey.currentState?.refreshBanners();
    _categoriesKey.currentState?.refreshCategories();
    _storesKey.currentState?.refreshStores();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
