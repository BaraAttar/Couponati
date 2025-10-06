// lib/features/coupon_card/coupon_card.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:my_app/features/home/models/store_model.dart';

class CouponCard extends StatelessWidget {
  final StoreModel store;
  const CouponCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(child: _buildStoreInfo(context)),
          _buildCouponsList(context),
        ],
      ),
    );
  }

  // ============ App Bar Section ============
  Widget _buildSliverAppBar(BuildContext context) {
    final coverHeight = MediaQuery.of(context).size.height * 0.25;

    return SliverAppBar(
      expandedHeight: coverHeight + 40,
      pinned: false,
      leading: const SizedBox.shrink(),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildStoreCover(context, coverHeight),
            _buildStoreLogo(context, coverHeight),
            _buildStoreActions(context, coverHeight),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreCover(BuildContext context, double coverHeight) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: coverHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.7),
            theme.colorScheme.primaryContainer,
          ],
        ),
      ),
    );
  }

  Widget _buildStoreLogo(BuildContext context, double coverHeight) {
    return Positioned(
      top: coverHeight - 40,
      right: 20,
      child: Hero(
        tag: 'store_${store.id}',
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200, width: 2),
            ),
            child: ClipOval(
              child: Image.network(
                store.icon,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildStorePlaceholder(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStorePlaceholder() {
    return Container(
      color: Colors.grey.shade100,
      child: Icon(Icons.store_rounded, size: 36, color: Colors.grey.shade400),
    );
  }

  Widget _buildStoreActions(BuildContext context, double coverHeight) {
    return Positioned(
      top: coverHeight + 10,
      left: 20,
      child: Row(
        children: [
          _buildActionButton(
            context,
            icon: Icons.share_rounded,
            onTap: () => _handleShare(context),
          ),
          const SizedBox(width: 10),
          _buildActionButton(
            context,
            icon: Icons.favorite_border_rounded,
            onTap: () => _handleFavorite(context),
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
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
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

  Widget _buildBackButton(BuildContext context) {
    final theme = Theme.of(context);
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 8,
      right: 16,
      child: Bounceable(
        onTap: () => Navigator.of(context).pop(),
        scaleFactor: 0.85,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  // ============ Store Info Section ============
  Widget _buildStoreInfo(BuildContext context) {
    final theme = Theme.of(context);
    final description = store.description.trim();

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            store.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ============ Coupons List Section ============
  Widget _buildCouponsList(BuildContext context) {
    final coupons = List.generate(5, (i) => i);

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildCouponItem(context, index),
          childCount: coupons.length,
        ),
      ),
    );
  }

  Widget _buildCouponItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final discount = (index + 1) * 10;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with discount badge
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Discount Badge
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$discount%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'خصم',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Coupon Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'خصم حصري على جميع المنتجات',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: theme.textTheme.bodySmall?.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'ينتهي خلال ${3 + index} أيام',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: theme.dividerColor.withValues(alpha: 0.3),
              height: 1,
            ),
          ),
          
          // Footer with code
          _CouponFooter(
            couponCode: 'SAVE${(index + 1) * 10}',
            theme: theme,
          ),
        ],
      ),
    );
  }

  // ============ Actions Handlers ============
  void _handleShare(BuildContext context) {
    // TODO: Implement share functionality
  }

  void _handleFavorite(BuildContext context) {
    // TODO: Implement favorite functionality
  }
}

// ============ Stateful Coupon Footer ============
class _CouponFooter extends StatefulWidget {
  final String couponCode;
  final ThemeData theme;

  const _CouponFooter({required this.couponCode, required this.theme});

  @override
  State<_CouponFooter> createState() => _CouponFooterState();
}

class _CouponFooterState extends State<_CouponFooter> {
  bool _isCopied = false;

  void _handleCopy() {
    setState(() => _isCopied = true);
    Clipboard.setData(ClipboardData(text: widget.couponCode));

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isCopied = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Code Display
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: widget.theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: widget.theme.colorScheme.outline
                      .withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.confirmation_number_outlined,
                    size: 18,
                    color: widget.theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.couponCode,
                    style: widget.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Copy Button
          Bounceable(
            onTap: _isCopied ? null : _handleCopy,
            scaleFactor: 0.9,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isCopied
                      ? [Colors.green, Colors.green.shade600]
                      : [
                          widget.theme.colorScheme.primary,
                          widget.theme.colorScheme.primary
                              .withValues(alpha: 0.8),
                        ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: (_isCopied ? Colors.green : widget.theme.colorScheme.primary)
                        .withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: Row(
                  key: ValueKey(_isCopied),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isCopied ? Icons.check_rounded : Icons.copy_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _isCopied ? 'تم' : 'نسخ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}