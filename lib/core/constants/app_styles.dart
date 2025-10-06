// lib/core/constants/app_styles.dart
import 'package:flutter/material.dart';

class AppStyles {
  // الظلال
  static List<BoxShadow> cardShadow(BuildContext context) {
    return [
      BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ];
  }

  static BoxDecoration defaultBoxDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: theme.colorScheme.secondary.withValues(alpha: 0.1)
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
    // return BoxDecoration(
    //   color: Theme.of(context).colorScheme.surface,
    //   borderRadius: AppStyles.defaultRadius,
    //   boxShadow: AppStyles.cardShadow(context),
    // );
  }

  // static BoxDecoration storeCardBoxDeconration(BuildContext context) {
  //   final theme = Theme.of(context);
  //   return BoxDecoration(
  //     // color: theme.colorScheme.surface,
  //     color: theme.cardColor,
  //     borderRadius: BorderRadius.circular(12),
  //     border: Border.all(
  //       color: theme.colorScheme.secondary.withValues(alpha: 0.1)
  //     ),
  //     boxShadow: [
  //       BoxShadow(
  //         color: Colors.black.withValues(alpha: 0.1),
  //         spreadRadius: 1,
  //         blurRadius: 5,
  //         offset: const Offset(0, 2),
  //       ),
  //     ],
  //   );
  // }

  // يمكنك إضافة أشياء أخرى
  static BorderRadius defaultRadius = BorderRadius.circular(12);
}
