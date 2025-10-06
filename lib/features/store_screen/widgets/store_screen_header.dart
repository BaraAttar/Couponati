import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:my_app/features/home/models/store_model.dart';
import 'package:my_app/features/home/widgets/store_card.dart';

class StoreScreenHeader extends StatelessWidget {
  final StoreModel store;
  const StoreScreenHeader({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final coverHeight = screenHeight * 0.20;
    return SizedBox(
      height: screenHeight * 0.30,
      child: Stack(
        children: [
          _storeCover(context, coverHeight),
          _topBarActions(context, coverHeight),
          _storeCard(context, coverHeight, store),
        ],
      ),
    );
  }

  Widget _storeCover(BuildContext context, double coverHeight) {
    return SizedBox(
      width: double.infinity,
      height: coverHeight,
      child: Image.asset(
        "assets/images/store-default-cover.jpg",
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(color: Colors.grey[400]);
        },
      ),
    );
  }

  Widget _storeCard(
    BuildContext context,
    double coverHeight,
    StoreModel store,
  ) {
    return Positioned(
      top: coverHeight - 60,
      left: 0,
      right: 0,
      child: StoreCard(store: store, isList: false),
    );
  }

  Widget _topBarActions(BuildContext context, double coverHeight) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      right: 20,
      left: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          _buildActionButton(
            context,
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => _handleBack(context),
          ),
          Row(
            children: [
              // Share Button
              _buildActionButton(
                context,
                icon: Icons.share_rounded,
                onTap: () => _handleShare(context),
              ),
              const SizedBox(width: 10),
              // Favorite Button
              _buildActionButton(
                context,
                icon: Icons.favorite_border_rounded,
                onTap: () => _handleFavorite(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Bounceable(
      onTap: onTap,
      scaleFactor: 0.85,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: theme.colorScheme.primary),
      ),
    );
  }

  void _handleBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _handleShare(BuildContext context) {
    // TODO: Implement share functionality
  }

  void _handleFavorite(BuildContext context) {
    // TODO: Implement favorite functionality
  }
}
