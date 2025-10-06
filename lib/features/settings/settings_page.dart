// lib/features/settings/settings_page.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app/features/settings/widgets/account_card/account_card.dart';
import 'package:my_app/features/settings/widgets/settings_card.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Stack(
      children: [
        // المحتوى القابل للسكرول
        Container(
          color: Theme.of(context).colorScheme.surfaceDim,
          child: SingleChildScrollView(
            child: SafeArea(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: size.height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [AccountCard(), SettingsCard()],
                ),
              ),
            ),
          ),
        ),

        // الطبقة الزجاجية الشفافة في الأعلى
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: MediaQuery.of(context).padding.top,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceDim.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
