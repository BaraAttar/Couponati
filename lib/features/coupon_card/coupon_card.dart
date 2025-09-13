import 'package:flutter/material.dart';
import 'package:my_app/features/main_pages/home/widgets/stores_list.dart';

class CouponCard extends StatelessWidget {
  final StoreItem store; // استلام بيانات المتجر

  const CouponCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [_storeCoverPhoto(context)]),
    );
  }

  Widget _storeCoverPhoto(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Scaffold(
        backgroundColor: Colors.red,
      ),
    );
  }
}
