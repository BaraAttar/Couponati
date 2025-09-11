import 'package:flutter/material.dart';

class StoreItem {
  final String name;
  final String? icon;

  const StoreItem({required this.name, this.icon});
}

class StoresList extends StatelessWidget {
  const StoresList({super.key});

  static final List<StoreItem> _storesIist = [
    StoreItem(name: "noon", icon: 'https://yt3.googleusercontent.com/ytc/AIdro_mmAjzVFCFpMD4PnOE9UwA_Bq8Nt7xKSfLqnp9VmETMC9Q=s900-c-k-c0x00ffffff-no-rj'),
    StoreItem(name: "noon", icon: 'assets/icons/alkkl.png'),
    StoreItem(name: "noon", icon: 'assets/icons/all.png'),
    StoreItem(name: "noon", icon: 'assets/icons/all.png'),
    StoreItem(name: "noon", icon: 'assets/icons/alم.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildStoreItem(context, _storesIist[index], index);
        },
        childCount: _storesIist.length, // عدد العناصر
      ),
    );
  }

  Widget _buildStoreItem(BuildContext context, StoreItem store, int index) {
    return Card(
      child: ListTile(
        title: Text(store.name),
        leading: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(child: _buildImageWithFallback(store)),
        ),
      ),
    );
  }

  Widget _buildImageWithFallback(StoreItem store) {
  if (store.icon == null || store.icon!.isEmpty) {
    return const Icon(Icons.store, size: 50);
  }

  // تمييز بين رابط الإنترنت والملف المحلي
  final isNetwork = store.icon!.startsWith('http');

  return isNetwork
      ? Image.network(
          store.icon!,
          width: 50,
          height: 50,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.store, size: 50);
          },
        )
      : Image.asset(
          store.icon!,
          width: 50,
          height: 50,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.store, size: 50);
          },
        );
}

}
