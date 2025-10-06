// lib/features/coupon_card/coupon_card.dart
import 'package:flutter/material.dart';
import 'package:my_app/features/home/models/store_model.dart';
import 'package:my_app/features/store_screen/widgets/coupons_list_view.dart';
import 'package:my_app/features/store_screen/widgets/store_screen_header.dart';

class StoreScreenView extends StatelessWidget {
  final StoreModel store;
  const StoreScreenView({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      backgroundColor: theme.colorScheme.surfaceDim,
      body: Column(
        children: [
          StoreScreenHeader(store: store),
          CouponsListView(couponsList: store.coupon),
        ],
      ),
    );
  }
}
