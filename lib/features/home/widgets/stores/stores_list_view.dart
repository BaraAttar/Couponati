import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:my_app/core/logger/logger_service.dart';
import 'package:my_app/features/coupon_card/coupon_card.dart';
import 'package:my_app/features/home/widgets/stores/store_list_logic.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ====================== Stores List (Main Widget) ======================
class StoresListView extends StatefulWidget {
  const StoresListView({super.key});

  @override
  State<StoresListView> createState() => _StoresListState();
}

class _StoresListState extends State<StoresListView> {
  late Future<List<StoreModel>> _fetchStores;
  final StoreController _controller = StoreController();
  Key _futureKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  void _loadStores() {
    _fetchStores = _controller.fetchStores();
  }

  void _reloadStores() {
    setState(() {
      _loadStores();
      _futureKey = UniqueKey();
    });
  }

  Widget _buildErrorWidget() {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'فشل تحميل المتاجر',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _reloadStores,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoresList(List<StoreModel> stores, bool isLoading) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Skeletonizer(
            enabled: isLoading,
            child: StoreItemTile(
              store: isLoading ? _getSkeletonStore() : stores[index],
            ),
          ),
          childCount: isLoading ? 4 : stores.length,
        ),
      ),
    );
  }

  StoreModel _getSkeletonStore() {
    return StoreModel(
      id: "****",
      name: "**************",
      description: "*******************************",
      icon: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StoreModel>>(
      key: _futureKey,
      future: _fetchStores,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          AppLogger.d(snapshot.error.toString());
          return _buildErrorWidget();
        }

        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final stores = snapshot.data ?? [];

        return _buildStoresList(stores, isLoading);
      },
    );
  }
}

// ====================== Store Item Tile ======================
class StoreItemTile extends StatelessWidget {
  final StoreModel store;

  const StoreItemTile({super.key, required this.store});

  void _navigateToCouponCard(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => CouponCard(store: store)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Bounceable(
      onTap: () => _navigateToCouponCard(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: _buildContainerDecoration(theme),
        child: Row(
          children: [
            // Store Image
            SizedBox(
              width: 70,
              height: 70,
              child: ClipOval(child: StoreImage(store: store)),
            ),
            const SizedBox(width: 16),
            // Store Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    store.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    store.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration(ThemeData theme) {
    return BoxDecoration(
      color: theme.colorScheme.surface,
      border: Border.all(color: theme.colorScheme.secondary),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          spreadRadius: 0.5,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

// ====================== Store Image Widget ======================
class StoreImage extends StatelessWidget {
  final StoreModel store;

  const StoreImage({super.key, required this.store});

  static final Widget _fallbackIcon = Container();

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = store.icon.startsWith('http');
    return isNetworkImage
        ? Image.network(
            store.icon,
            fit: BoxFit.cover,
            cacheWidth: 100,
            cacheHeight: 100,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.store, size: 50);
            },
          )
        : Image.asset(
            "assets/icons/store.png",
            fit: BoxFit.cover,
            cacheWidth: 100,
            cacheHeight: 100,
            errorBuilder: (_, __, ___) => _fallbackIcon,
          );
  }
}
