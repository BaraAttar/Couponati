import 'package:flutter/material.dart';
import 'package:my_app/features/auth/auth_controller.dart';
import 'package:my_app/features/auth/widgets/google_signin_button.dart';
import 'package:provider/provider.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthController>(
          builder: (context, auth, child) {
            if (auth.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            
            if (auth.isLoggedIn == false) {
              return _buildGuestView(context);
            }
            
            return _buildFavouritesView(auth);
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
                  color: theme.colorScheme.primary.withValues(alpha:0.3),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'المفضلة',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'سجّل الدخول لحفظ قائمة المتاجر المفضلة',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 32),
            GoogleSigninButton()
          ],
        ),
      ),
    );
  }

  Widget _buildFavouritesView(AuthController auth) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'مرحباً ${auth.user?.firstName ?? ''}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          const Text('قائمة المفضلة ستظهر هنا'),
        ],
      ),
    );
  }
}