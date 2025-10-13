import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:my_app/core/constants/app_styles.dart';
import 'package:my_app/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (_) => const ThemeBottomSheet(),
    );
  }

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  late String currentTheme;

  @override
  void initState() {
    super.initState();
    final themeProvider = context.read<ThemeProvider>();
    currentTheme = themeProvider.themeMode == ThemeMode.light
        ? 'light'
        : 'dark';
  }

  void changeThemeBtn(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    themeProvider.setTheme(
      currentTheme == 'light' ? ThemeMode.light : ThemeMode.dark,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            currentTheme = value;
          });
        }
      },
      groupValue: currentTheme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),

          RadioListTile<String>(value: 'light', title: const Text('light')),
          RadioListTile<String>(value: 'dark', title: const Text('dark')),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _changeTemeBtn(context),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _changeTemeBtn(BuildContext context) {
    return Bounceable(
      onTap: () => changeThemeBtn(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: AppStyles.defaultRadius,
        ),
        child: Center(
          child: Text(
            "Change Theme",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}
