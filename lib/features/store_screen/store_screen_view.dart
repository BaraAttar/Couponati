// lib/features/coupon_card/coupon_card.dart
import 'package:flutter/material.dart';
import 'package:my_app/features/home/models/store_model.dart';
import 'package:my_app/features/store_screen/controllers/trackevents_controller.dart';
import 'package:my_app/features/store_screen/widgets/coupons_list_view.dart';
import 'package:my_app/features/store_screen/widgets/store_screen_header.dart';

class StoreScreenView extends StatefulWidget {
  final StoreModel store;
  const StoreScreenView({super.key, required this.store});

  @override
  State<StoreScreenView> createState() => _StoreScreenViewState();
}

class _StoreScreenViewState extends State<StoreScreenView> {
  final TrackeventsController _controller = TrackeventsController();

  @override
  void initState() {
    super.initState();
    _controller.postStoreViewEvent(widget.store.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceDim,
      body: Column(
        children: [
          StoreScreenHeader(store: widget.store),
          CouponsListView(
            couponsList: widget.store.coupon,
            onCouponCopied: (couponId) {
              _controller.postCodeCopiedEvent(couponId);
            },
          ),
        ],
      ),
    );
  }
}
