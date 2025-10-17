import 'package:flutter/material.dart';
import 'package:my_app/features/auth/auth_controller.dart';
import 'package:my_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class AccountServerError extends StatelessWidget {
  const AccountServerError({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, _) {
        return Column(
          children: [
            Icon(Icons.cloud_off, size: 48, color: Colors.red[400]),
            const SizedBox(height: 12),
            Text(
              S.of(context).account_server_error_title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              auth.errorMessage ?? S.of(context).account_server_error_unknown,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                auth.checkIfLoggedIn();
              },
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(S.of(context).account_server_error_retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
