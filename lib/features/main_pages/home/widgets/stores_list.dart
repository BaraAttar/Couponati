import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_app/features/coupon_card/coupon_card.dart';

class StoreItem {
  final String name;
  final String? icon;

  const StoreItem({required this.name, this.icon});
}

class StoresList extends StatelessWidget {
  const StoresList({super.key});

  static final List<StoreItem> _storesIist = [
    StoreItem(
      name: "noon",
      icon:
          'https://yt3.googleusercontent.com/ytc/AIdro_mmAjzVFCFpMD4PnOE9UwA_Bq8Nt7xKSfLqnp9VmETMC9Q=s900-c-k-c0x00ffffff-no-rj',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
    StoreItem(
      name: "temo",
      icon:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkmJYvJlgzY3Y0SO1BKo4DY_yadZArGRkSIQ&s',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _buildStoreItem(context, _storesIist[index], index);
        }, childCount: _storesIist.length),
      ),
    );
  }

  void _onTabLogic(BuildContext context, StoreItem store) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => CouponCard(store: store)));
  }

  // الحل الأول: إزالة margin بين العناصر وتقليل border radius
  Widget _buildStoreItem(BuildContext context, StoreItem store, int index) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _onTabLogic(context, store),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ), // تقليل vertical margin
        child: ClipRRect(
          // استخدام ClipRRect بدلاً من ClipRect
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.7),
                border: Border.all(
                  color: theme.colorScheme.secondary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              height: 80,
              padding: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(store.name),
                leading: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(child: _buildImageWithFallback(store)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithFallback(StoreItem store) {
    if (store.icon == null || store.icon!.isEmpty) {
      return const Icon(Icons.store, size: 50);
    }

    final isNetwork = store.icon!.startsWith('http');

    return AspectRatio(
      aspectRatio: 1.0,
      child: isNetwork
          ? Image.network(
              store.icon!,
              fit: BoxFit.cover,
              cacheWidth: 100,
              cacheHeight: 100,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.store, size: 30, color: Colors.white);
              },
            )
          : Image.asset(
              store.icon!,
              fit: BoxFit.cover,
              cacheWidth: 100,
              cacheHeight: 100,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.store, size: 30, color: Colors.white);
              },
            ),
    );
  }
}
