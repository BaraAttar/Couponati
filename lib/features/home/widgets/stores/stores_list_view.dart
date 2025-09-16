import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:my_app/features/coupon_card/coupon_card.dart';
import 'package:my_app/features/home/widgets/stores/store_list_logic.dart';

// ====================== Stores List (Main Widget) ======================
class StoresListView extends StatefulWidget {
  const StoresListView({super.key});

  @override
  State<StoresListView> createState() => _StoresListState();
}

class _StoresListState extends State<StoresListView> {
  late final Future<List<StoreModel>> _storesList;
  final StoreController controller = StoreController();

  @override
  void initState() {
    super.initState();
    _storesList = controller.fetchStores();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StoreModel>>(
      future: _storesList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: const Center(child: Text('Error loading banners')),
          );
        }

        final stores = (snapshot.data != null && snapshot.data!.isNotEmpty)
            ? snapshot.data!
            : [StoreModel(id: "", name: "", icon: "")];

        return SliverPadding(
          padding: EdgeInsets.only(bottom: 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => StoreItemTile(store: stores[index]),
              childCount: stores.length,
            ),
          ),
        );
      },
    );
  }
}

// ====================== Store Item Tile ======================
class StoreItemTile extends StatelessWidget {
  final StoreModel store;
  const StoreItemTile({super.key, required this.store});

  void _onTap(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => CouponCard(store: store)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Bounceable(
      onTap: () => _onTap(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        height: 80,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.secondary, width: 1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ListTile(
            title: Text(store.name),
            leading: ClipOval(child: StoreImage(store: store)),
          ),
        ),
      ),
    );
  }
}

// ====================== Store Image Widget ======================
class StoreImage extends StatelessWidget {
  final StoreModel store;
  const StoreImage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    if (store.icon == null || store.icon!.isEmpty) {
      return const Icon(Icons.store, size: 50);
    }

    final isNetwork = store.icon!.startsWith('http');

    return AspectRatio(
      aspectRatio: 1.0,
      child: isNetwork
          ? Image.network(
              store.icon!,
              fit: BoxFit.cover,
              cacheWidth: 100,
              cacheHeight: 100,
              loadingBuilder: (context, child, progress) => progress == null
                  ? child
                  : const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.store, size: 30, color: Colors.white),
            )
          : Image.asset(
              store.icon!,
              fit: BoxFit.cover,
              cacheWidth: 100,
              cacheHeight: 100,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.store, size: 30, color: Colors.white),
            ),
    );
  }
}
