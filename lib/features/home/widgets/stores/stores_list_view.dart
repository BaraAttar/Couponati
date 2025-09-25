import 'package:flutter/material.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/features/home/widgets/stores/store_controller.dart';
import 'package:my_app/features/home/widgets/stores/store_model.dart';
import 'package:my_app/features/home/widgets/stores/widgets/store_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoresListView extends StatefulWidget {
  final ScrollController controller;
  const StoresListView({super.key, required this.controller});

  @override
  State<StoresListView> createState() => StoresListViewState();
}

class StoresListViewState extends State<StoresListView> {
  final StoreController _controller = StoreController();
  List<StoreModel> _stores = [];
  bool _isLoading = false;
  String? _error;
  bool _hasMoreData = true;
  int _currentPage = 1;
  int _totalCount = 0;
  String? _currentCategoryId;

  @override
  void initState() {
    super.initState();
    loadStores(page: 1);
    widget.controller.addListener(_scrollListener);
  }

  Future<void> refreshStores({String? categoryId}) async {
    _currentCategoryId = categoryId;

    setState(() {
      _stores.clear();
      _currentPage = 1;
      _hasMoreData = true;
      _error = null;
    });

    await loadStores(page: 1, categoryId: _currentCategoryId);
  }

  Future<void> loadStores({int page = 1, String? categoryId}) async {
    final catId = categoryId ?? _currentCategoryId;

    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _controller.fetchStores(
        page: page,
        categoryId: catId,
      );

      if (!mounted) return;
      setState(() {
        if (page == 1) _stores = result.data;
        else _stores.addAll(result.data);

        _isLoading = false;
        _totalCount = result.totalCount;
        _hasMoreData = _stores.length < _totalCount;
        _currentPage = page;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
      AppLogger.d(_error.toString());
    }
  }

  void _scrollListener() {
    final maxScroll = widget.controller.position.maxScrollExtent;
    final currentScroll = widget.controller.position.pixels;

    if (_isLoading || !_hasMoreData) return;
    if (currentScroll >= maxScroll - 100) _loadNextPage();
  }

  Future<void> _loadNextPage() async {
    if (_isLoading || !_hasMoreData) return;
    final nextPage = _currentPage + 1;
    await loadStores(page: nextPage, categoryId: _currentCategoryId);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null && _stores.isEmpty) {
      return SliverToBoxAdapter(
          child: Center(child: Text("خطأ: $_error")));
    }

    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index < _stores.length) {
              return StoreCard(store: _stores[index]);
            } else if (_isLoading) {
              return Column(
                children: List.generate(
                  3,
                  (_) => Skeletonizer(
                    child: StoreCard(
                      store: StoreModel(
                        id: "skeleton",
                        name: "Loading Store...",
                        icon: "",
                        description: "Please wait...",
                      ),
                    ),
                  ),
                ),
              );
            } else if (!_hasMoreData) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: Text("لا توجد متاجر أخرى")),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
          childCount: _stores.length + (_isLoading || !_hasMoreData ? 1 : 0),
        ),
      ),
    );
  }
}
