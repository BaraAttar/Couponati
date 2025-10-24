import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_app/features/auth/auth_controller.dart';
import 'package:my_app/features/auth/widgets/google_signin_button.dart';
import 'package:my_app/features/favourites/favourites_controller.dart';
import 'package:my_app/features/home/models/store_model.dart';
import 'package:my_app/features/home/widgets/store_card.dart';
import 'package:my_app/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  Future<void> _onRefresh(FavouritesController favController) async {
    await favController.fetchFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final favController = context.read<FavouritesController>();
    final headerHeight = kToolbarHeight + MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: Stack(
        children: [
          // ✅ المحتوى الرئيسي مع السحب للتحديث
          RefreshIndicator(
            displacement: headerHeight + 20,
            onRefresh: () => _onRefresh(favController),
            child: Consumer<AuthController>(
              builder: (context, auth, _) {
                if (auth.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!auth.isLoggedIn) {
                  return _buildGuestView(context, headerHeight);
                }

                return Consumer<FavouritesController>(
                  builder: (context, favourites, _) {
                    if (favourites.isLoading) {
                      return _loadingSkeletonContent(headerHeight);
                    }

                    final favList = favourites.favourites;

                    if (favList.isEmpty) {
                      return _emptyFavouritesView(context, headerHeight);
                    }

                    return _favouritesListContent(
                      context,
                      favList,
                      headerHeight,
                    );
                  },
                );
              },
            ),
          ),

          // ✅ الهيدر الزجاجي (Blur)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: headerHeight,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.7),
                  ),
                  child: Text(
                    S.of(context).favourites_title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🩵 واجهة المستخدم في حال المستخدم ضيف
  Widget _buildGuestView(BuildContext context, double headerHeight) {
    final theme = Theme.of(context);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: headerHeight + 40, left: 24, right: 24),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/sign-in.png',
              width: 240,
              height: 240,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.favorite_border_rounded,
                  size: 120,
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              S.of(context).favourites_welcome_title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              S.of(context).favourites_welcome_subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 32),
            const GoogleSigninButton(),
          ],
        ),
      ],
    );
  }

  /// 🩶 محتوى التحميل (skeletons)
  Widget _loadingSkeletonContent(double headerHeight) {
    return ListView.builder(
      padding: EdgeInsets.only(top: headerHeight + 8, bottom: 32),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Skeletonizer(
          child: StoreCard(
            store: StoreModel(
              id: "id",
              name: "name",
              icon: "icon",
              description: "description",
            ),
          ),
        );
      },
    );
  }

  /// ❤️ قائمة المفضلات
  Widget _favouritesListContent(
    BuildContext context,
    List<StoreModel> favouritesList,
    double headerHeight,
  ) {
    return ListView.builder(
      padding: EdgeInsets.only(top: headerHeight + 8, bottom: 32),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: favouritesList.length,
      itemBuilder: (context, index) {
        final store = favouritesList[index];
        return StoreCard(store: store);
      },
    );
  }

  /// 🩶 في حال لا توجد مفضلة
  Widget _emptyFavouritesView(BuildContext context, double headerHeight) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: headerHeight + 100),
      children: [
        Center(
          child: Text(
            S.of(context).favourites_no_favourites,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
