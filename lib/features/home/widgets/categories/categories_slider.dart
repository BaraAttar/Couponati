import 'package:flutter/material.dart';

class CategoriesSlider extends StatefulWidget {
  const CategoriesSlider({super.key});

  @override
  State<CategoriesSlider> createState() => _CategoriesSliderState();
}

class CategoryItem {
  final String name;
  final String? icon;
  final IconData? fallbackIcon;

  const CategoryItem({
    required this.name,
    this.icon,
    this.fallbackIcon = Icons.category,
  });
}

class _CategoriesSliderState extends State<CategoriesSlider> {
  static const List<CategoryItem> _sliderItems = [
    CategoryItem(
      name: 'All',
      icon: 'assets/icons/all.png',
      fallbackIcon: Icons.apps,
    ),
    CategoryItem(
      name: 'clothes',
      icon: 'assets/icons/clothes.png',
      fallbackIcon: Icons.checkroom,
    ),
    CategoryItem(
      name: 'flowers',
      icon: 'assets/icons/flowers.png',
      fallbackIcon: Icons.local_florist,
    ),
    CategoryItem(
      name: 'children',
      icon: 'assets/icons/children.png',
      fallbackIcon: Icons.child_care,
    ),
    CategoryItem(
      name: 'flight',
      icon: 'assets/icons/flight.png',
      fallbackIcon: Icons.flight,
    ),
    CategoryItem(
      name: 'electronics',
      icon: 'assets/icons/electronics.png',
      fallbackIcon: Icons.electrical_services,
    ),
    CategoryItem(
      name: 'Perfumes',
      icon: 'assets/icons/perfumes.png',
      fallbackIcon: Icons.spa,
    ),
    CategoryItem(
      name: 'Delivery',
      icon: 'assets/icons/delivery.png',
      fallbackIcon: Icons.spa,
    ),
    CategoryItem(
      name: 'Health',
      icon: 'assets/icons/health.png',
      fallbackIcon: Icons.health_and_safety_outlined,
    ),
    CategoryItem(
      name: 'toys',
      icon: 'assets/icons/toys.png',
      fallbackIcon: Icons.toys,
    ),
  ];

  int _selectedIndex = 0;

  // معالج لأخطاء الصور مع ضبط أفضل للموضع
  Widget _buildImageWithFallback(CategoryItem item) {
    final colorScheme = Theme.of(context).colorScheme;

    if (item.icon == null || item.icon!.isEmpty) {
      return Center(child: Icon(item.fallbackIcon ?? Icons.category, size: 30));
    }

    return Center(
      child: Image.asset(
        item.icon!,
        width: 35,
        height: 35,
        fit: BoxFit.contain, // تغيير إلى contain للحفاظ على النسب
        color: colorScheme.primary, // اللون المطلوب
        colorBlendMode: BlendMode.srcIn,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('خطأ في تحميل الصورة: ${item.icon} - $error');
          return Icon(item.fallbackIcon ?? Icons.category, size: 30);
        },
      ),
    );
  }

  Widget _buildSliderItem(BuildContext context, CategoryItem item, int index) {
    bool isSelected = _selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(3), // زيادة البادينج قليلاً
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? colorScheme.primary : colorScheme.secondary,
                width: isSelected ? 2 : 1, // حدود أوضح للعنصر المحدد
              ),
            ),
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(child: _buildImageWithFallback(item)),
            ),
          ),
          const SizedBox(height: 4), // مساحة ثابتة بدلاً من Padding
          Text(
            item.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? colorScheme.primary : Colors.grey[700],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (int index = 0; index < _sliderItems.length; index++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _buildSliderItem(context, _sliderItems[index], index),
              ),
          ],
        ),
      ),
    );
  }
}
