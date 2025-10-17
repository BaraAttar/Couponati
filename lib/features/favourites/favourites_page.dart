import 'package:flutter/material.dart';
// import 'package:my_app/core/logger/logger_service.dart';
// import 'package:my_app/core/storage/token_storage.dart';
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

  @override
  Widget build(BuildContext context) {
    // void onPressed() async {
    //   final token = await TokenStorage.getToken();
    //   AppLogger.d(token.toString());
    // }

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).favourites_title), centerTitle: true),
      body: SafeArea(
        child: Consumer<AuthController>(
          builder: (context, auth, child) {
            // return ElevatedButton(onPressed: onPressed, child: Text("token"));
            if (auth.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!auth.isLoggedIn) {
              return _buildGuestView(context);
            }

            final favController = context.read<FavouritesController>();

            // تحميل المفضلة عند تسجيل الدخول إذا كانت فارغة
            if (favController.favourites.isEmpty && !favController.isLoading) {
              favController.fetchFavourites();
            }

            return Consumer<FavouritesController>(
              builder: (context, favourites, child) {
                if (favourites.isLoading) {
                  return _loadingSkeletonContent();
                }

                if (favourites.favourites.isEmpty) {
                  return Center(
                    child: Text(S.of(context).favourites_no_favourites),
                  );
                }

                return _favouritesListContent(context, favourites.favourites);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildGuestView(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
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
            GoogleSigninButton(),
          ],
        ),
      ),
    );
  }

  Widget _loadingSkeletonContent() {
    return ListView.builder(
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

  Widget _favouritesListContent(
    BuildContext context,
    List<StoreModel> favouritesList,
  ) {
    return ListView.builder(
      itemCount: favouritesList.length,
      itemBuilder: (context, index) {
        // AppLogger.d(favouritesList[index].coupon.length.toString());
        final store = favouritesList[index];
        return StoreCard(store: store);
      },
    );
  }
}
