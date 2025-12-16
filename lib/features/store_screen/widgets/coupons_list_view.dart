import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:my_app/features/store_screen/models/coupon_model.dart';
import 'package:my_app/generated/l10n.dart';

class CouponsListView extends StatelessWidget {
  final List<CouponModel> couponsList;
  final void Function(String couponId)? onCouponCopied;

  const CouponsListView({
    super.key,
    required this.couponsList,
    this.onCouponCopied,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: couponsList.length,
        itemBuilder: (context, index) {
          final coupon = couponsList[index];
          return _couponCard(context, coupon);
        },
      ),
    );
  }

  Widget _couponCard(BuildContext context, CouponModel coupon) {
    final lineColor = Theme.of(context).colorScheme.surfaceDim;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // المحتوى الرئيسي
          Row(
            textDirection: TextDirection.rtl,
            children: [
              // الجزء الأيمن - معلومات الكوبون
              Flexible(flex: 3, child: _rightPart(context, coupon)),

              // الجزء الأيسر - نسبة الخصم
              Flexible(flex: 2, child: _leftPart(context, coupon)),
            ],
          ),

          // الخط المنقط
          Positioned(
            top: 0,
            bottom: 0,
            left: 15,
            right: 0,
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Flexible(flex: 3, child: Container()),
                CustomPaint(
                  painter: DashedLinePainter(lineColor),
                  size: const Size(1, double.infinity),
                ),
                Flexible(flex: 2, child: Container()),
              ],
            ),
          ),

          // الدوائر
          ..._circleCuts(context),
        ],
      ),
    );
  }

  Widget _leftPart(BuildContext context, CouponModel coupon) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 6, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Color(0xFF41A67E).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${coupon.discount}%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF41A67E),
                  height: 1,
                ),
              ),
            ),

            _copyButton(context, textToCopy: coupon.code),
          ],
        ),
      ),
    );
  }

  Widget _copyButton(BuildContext context, {String? textToCopy}) {
    bool isCopied = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Bounceable(
          onTap: isCopied
              ? null
              : () {
                  if (textToCopy != null) {
                    Clipboard.setData(ClipboardData(text: textToCopy));
                    setState(() => isCopied = true);
                    Future.delayed(
                      const Duration(seconds: 2),
                      () => setState(() => isCopied = false),
                    );
                    if (onCouponCopied != null) {
                      onCouponCopied!(textToCopy);
                    }
                  }
                },
          child: Container(
            width: 80,
            height: 35,
            decoration: BoxDecoration(
              color: isCopied
                  ? Color(0xFF41A67E)
                  : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isCopied
                      ? S.of(context).coupon_copied
                      : S.of(context).coupon_copy,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  isCopied ? Icons.check_rounded : Icons.copy_rounded,
                  size: 20,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _rightPart(BuildContext context, CouponModel coupon) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceDim.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: Center(
                  child: Text(
                    coupon.code,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              // color: Colors.amber,
              child: Text(
                textAlign: TextAlign.center,
                coupon.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _circleCuts(BuildContext context) {
    return [
      Positioned(
        left: 0,
        right: 0,
        top: -8,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Flexible(flex: 3, child: Container()),
            Transform.translate(
              offset: const Offset(8, 0),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceDim,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Flexible(flex: 2, child: Container()),
          ],
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: -8,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Flexible(flex: 3, child: Container()),
            Transform.translate(
              offset: const Offset(8, 0),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceDim,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Flexible(flex: 2, child: Container()),
          ],
        ),
      ),
    ];
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  DashedLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    const dashHeight = 6;
    const dashSpace = 4;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
