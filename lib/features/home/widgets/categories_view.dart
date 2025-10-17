// lib/features/home/widgets/categories/categories_slider.dart
import 'package:flutter/material.dart';
import 'package:my_app/features/home/controllers/categories_controller.dart';
import 'package:my_app/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesSlider extends StatefulWidget {
  final void Function(String id)? onCategorySelected;

  const CategoriesSlider({super.key, this.onCategorySelected});

  @override
  State<CategoriesSlider> createState() => CategoriesSliderState();
}

class CategoriesSliderState extends State<CategoriesSlider> {
  CategoriesController? controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller ??= Provider.of<CategoriesController>(context);
  }

  Future<void> refreshCategories() async {
    await controller?.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    if (controller!.isLoading) {
      return _loadingSkeleton();
      //   return _loadingSkeleton();
      //   return const Padding(
      //     padding: EdgeInsets.all(10),
      //     child: Center(child: CircularProgressIndicator()),
      //   );
    }

    if (controller!.success == false || controller!.categories.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Center(child: Text(S.of(context).categories_no_categories)),
      );
    }

    return IntrinsicHeight(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: controller!.categories.map((category) {
            return _categoryItem(context, controller, category);
          }).toList(),
        ),
      ),
    );
  }

  Widget _loadingSkeleton() {
    return Skeletonizer(
      child: IntrinsicHeight(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: List.generate(
              5,
              (index) => Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 65,
                    height: 65,
                    child: ClipOval(child: ColoredBox(color: Colors.black)),
                  ),
                  Text(S.of(context).categories_loading_placeholder),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryItem(BuildContext context, controller, category) {
    final isSelected = category.id == controller.selectedCategoryId;
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        controller.setSelectedCategoryId(category.id);
        if (widget.onCategorySelected != null) {
          widget.onCategorySelected!(category.id);
        }
      },
      child: Column(
        children: [
          // إضافة AnimatedContainer للانيميشن السلس
          AnimatedContainer(
            duration: const Duration(milliseconds: 200), // مدة الانيميشن
            curve: Curves.easeInOut, // نوع الانيميشن
            margin: EdgeInsets.all(10),
            width: 60,
            height: 60,
            child: _categoryIcon(context, category.icon, isSelected),
          ),
          const SizedBox(height: 4),
          // إضافة انيميشن للنص أيضاً
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? theme.primary : Colors.grey[700],
            ),
            child: Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryIcon(BuildContext context, icon, isSelected) {
    final theme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200), // انيميشن للكونتينر
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.surfaceBright.withValues(alpha: 0.9),
            theme.surfaceBright.withValues(alpha: 0.3),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
        border: BoxBorder.all(
          color: isSelected
              ? theme.primary.withValues(alpha: 0.3)
              : theme.secondary.withValues(alpha: 0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ClipOval(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200), // انيميشن للـ padding
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(
            isSelected ? 10.0 : 14.0,
          ), // تقليل الـ padding عند التحديد
          child: _buildImageWithFallback( context,icon),
        ),
      ),
    );
  }

  Widget _buildImageWithFallback(BuildContext context, dynamic icon) {
    // التحقق من وجود الأيقونة
    if (icon == null || icon.toString().trim().isEmpty) {
      return _buildFallbackIcon();
    }

    final String iconPath = "assets/icons/${icon.toString().trim()}.png";

    return Image.asset(
      iconPath,
      width: 40,
      height: 40,
      fit: BoxFit.contain,
      color: Theme.of(context).colorScheme.primary,
      errorBuilder: (context, error, stackTrace) {
        return _buildFallbackIcon();
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;

        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },
    );
  }

  Widget _buildFallbackIcon() {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(5),
      child: Image.asset(
        "assets/icons/store.png",
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('خطأ في تحميل الصورة الاحتياطية: $error');
          return Icon(Icons.store_outlined, size: 28, color: Colors.grey[600]);
        },
      ),
    );
  }
}
