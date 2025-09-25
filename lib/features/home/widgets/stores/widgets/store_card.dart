// lib/features/home/widgets/stores/widgets/store_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:my_app/features/home/widgets/stores/store_model.dart';

class StoreCard extends StatelessWidget {
  final StoreModel store;
  const StoreCard({super.key, required this.store});

  void _navigateToCouponCard(BuildContext context) {
    // Navigator.of(
    //   context,
    // ).push(MaterialPageRoute(builder: (_) => ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Bounceable(
      onTap: () => {_navigateToCouponCard(context)},
      duration: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.surfaceDim.withValues(alpha: 0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _storeImage(context, store.icon),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    store.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    store.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _storeImage(BuildContext context, String icon) {
    return ClipOval(
      child: SizedBox(width: 65, height: 65, child: _imageWithFallback(icon)),
    );
  }

  Widget _imageWithFallback(String icon) {
    if (icon.isEmpty) {
      return Image.asset(
        "assets/icons/store.png",
        fit: BoxFit.cover,
        width: 65,
        height: 65,
      );
    }

    final isNetworkImage = icon.startsWith('http');
    return isNetworkImage
        ? Image.network(
            icon,
            fit: BoxFit.cover,
            cacheWidth: 150,
            cacheHeight: 150,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/icons/store.png");
            },
          )
        : Image.asset(
            "assets/icons/store.png",
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.store, size: 40),
          );
  }
}
