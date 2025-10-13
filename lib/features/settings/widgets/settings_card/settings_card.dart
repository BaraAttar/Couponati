import 'package:flutter/material.dart';
import 'package:my_app/core/constants/app_styles.dart';
import 'package:my_app/features/settings/widgets/settings_card/language_bottom_sheet.dart';
import 'package:my_app/features/settings/widgets/settings_card/theme_bottom_sheet.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: AppStyles.defaultBoxDecoration(context),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان القسم
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              'الإعدادات',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: primary,
                letterSpacing: -0.5,
              ),
            ),
          ),

          // عناصر الإعدادات
          _settingItem(
            context,
            icon: Icons.notifications_rounded,
            title: 'الإشعارات',
            subtitle: 'إدارة التنبيهات',
            color: Colors.orange,
            onTap: () {},
          ),

          _settingItem(
            context,
            icon: Icons.language_rounded,
            title: 'اللغة',
            subtitle: 'العربية',
            color: Colors.blue,
            onTap: () => LanguageBottomSheet.show(context),
          ),

          _settingItem(
            context,
            icon: Icons.dark_mode_rounded,
            title: 'المظهر',
            subtitle: 'فاتح / داكن',
            color: Colors.indigo,
            onTap: () => ThemeBottomSheet.show(context),
          ),

          _settingItem(
            context,
            icon: Icons.privacy_tip_rounded,
            title: 'الخصوصية والأمان',
            subtitle: 'إعدادات الحماية',
            color: Colors.green,
            onTap: () {},
          ),

          _settingItem(
            context,
            icon: Icons.help_rounded,
            title: 'المساعدة والدعم',
            subtitle: 'الأسئلة الشائعة',
            color: Colors.purple,
            onTap: () {},
          ),

          _settingItem(
            context,
            icon: Icons.info_rounded,
            title: 'حول التطبيق',
            subtitle: 'الإصدار 1.0.0',
            color: Colors.grey,
            onTap: () {},
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _settingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  // أيقونة ملونة مع خلفية
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, size: 22, color: color),
                  ),
                  const SizedBox(width: 16),

                  // النصوص
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primary,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // السهم
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(right: 80),
            child: Divider(height: 1, thickness: 0.5, color: Colors.grey[300]),
          ),
      ],
    );
  }
}
