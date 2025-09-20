import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:my_app/features/home/widgets/stores/store_list_logic.dart';
import 'package:my_app/features/home/widgets/stores/stores_list_view.dart';

class CouponCard extends StatelessWidget {
  final StoreModel store;
  const CouponCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final double coverHeight = MediaQuery.of(context).size.height * 0.20;

    // AppLogger.d(jsonEncode(store.toJson()));
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              _storeCover(context, coverHeight),
              _logoActionsRow(context, store.icon, coverHeight),
              Positioned(top: 50, right: 10, child: _backButton(context)),
            ],
          ),
          _description(context, "description"),
          Expanded(child: _couponse()),
        ],
      ),
    );
  }

  Widget _description(BuildContext context, String description) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),

        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: theme.colorScheme.secondary),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Store Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "description description description description description description description description description",
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoActionsRow(
    BuildContext context,
    String icon,
    double coverHeight,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: coverHeight - 40, right: 20, left: 20),
      child: Row(
        children: [
          _storeLogo(context, icon, coverHeight),
          Spacer(),
          _storeActions(context),
        ],
      ),
    );
  }

  Widget _storeActions(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
              child: (Icon(
                Icons.share_outlined,
                size: 30,
                color: theme.colorScheme.primary,
              )),
            ),
            Icon(Icons.favorite, size: 40, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _couponse() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 500,
            color: Colors.green,
            margin: const EdgeInsets.all(8),
            child: const Center(child: Text('Action 1')),
          ),
          Container(
            height: 500,
            color: Colors.blue,
            margin: const EdgeInsets.all(8),
            child: const Center(child: Text('Action 2')),
          ),
          Container(
            height: 500,
            color: Colors.orange,
            margin: const EdgeInsets.all(8),
            child: const Center(child: Text('Action 3')),
          ),
          // أضف المزيد حسب الحاجة
        ],
      ),
    );
  }

  Widget _storeLogo(BuildContext context, String icon, double coverHeight) {
    return Container(
      padding: const EdgeInsets.all(4), // سماكة البوردر
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.9), // لون فاتح (لمعة)
            Colors.white.withValues(alpha: 0.3), // شفاف (انعكاس زجاج)
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(2, 2), // يضيف عمق
          ),
        ],
      ),
      child: ClipOval(
        child: SizedBox(width: 80, height: 80, child: StoreImage(store: store)),
      ),
    );
  }

  Widget _storeCover(BuildContext context, double coverHeight) {
    return SizedBox(
      width: double.infinity,
      height: coverHeight,
      child: Container(color: Colors.blue),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  Widget _backButton(BuildContext context) {
    final theme = Theme.of(context);

    return Bounceable(
      onTap: () {
        _onTap(context);
      },
      curve: Curves.bounceIn,
      duration: Duration(milliseconds: 500),
      scaleFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.9),
              Colors.white.withValues(alpha: 0.3),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        width: 45,
        height: 45,
        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 25,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
