import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:my_app/core/constants/app_styles.dart';
import 'package:my_app/core/locale/locale_provider.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const LanguageBottomSheet(),
    );
  }

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late String currentLang;

  @override
  void initState() {
    super.initState();
    final localeProvider = context.read<LocaleProvider>();
    currentLang = localeProvider.locale.languageCode;
  }

  void changeLanguageBtn(BuildContext context) {
    final localeProvider = context.read<LocaleProvider>();
    localeProvider.setLocale(Locale(currentLang));
    Navigator.pop(context);
    AppLogger.d("Language changed to: $currentLang");
  }
  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            currentLang = value;
          });
        }
      },
      groupValue: currentLang,
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

          RadioListTile<String>(value: 'ar', title: const Text('العربية')),
          RadioListTile<String>(value: 'en', title: const Text('English')),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _changeLanguageBtn(context),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _changeLanguageBtn(BuildContext context) {
    return Bounceable(
      onTap: () => changeLanguageBtn(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: AppStyles.defaultRadius,
        ),
        child: Center(
          child: Text(
            "Change Language",
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
