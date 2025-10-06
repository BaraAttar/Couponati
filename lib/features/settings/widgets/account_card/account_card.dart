import 'package:flutter/material.dart';
import 'package:my_app/core/constants/app_styles.dart';
import 'package:my_app/features/auth/auth_controller.dart';
import 'package:my_app/features/auth/widgets/google_signin_button.dart';
import 'package:my_app/features/settings/widgets/account_card/account_server_error_view.dart';
import 'package:my_app/features/settings/widgets/account_card/account_actions.dart';
import 'package:my_app/features/settings/widgets/account_card/guest_welcome_message.dart';
import 'package:my_app/features/settings/widgets/account_card/logged_in_user_info.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, child) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: AppStyles.defaultBoxDecoration(context),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: _buildContent(auth),
        );
      },
    );
  }

  Widget _buildContent(AuthController auth) {
    if (auth.isLoading) {
      return Skeletonizer(
        child: _buildUserView(auth),
      );
    }

    if (!auth.isLoggedIn && (auth.errorMessage?.isNotEmpty ?? false)) {
      return const AccountServerError();
    }

    return _buildUserView(auth);
  }

  Widget _buildUserView(AuthController auth) {
    return Column(
      children: [
        auth.isLoggedIn
            ? LoggedInUserInfo(auth: auth)
            : const GuestWelcomeMessage(),
        if (!auth.isLoggedIn) const SizedBox(height: 24),
        if (!auth.isLoggedIn) const GoogleSigninButton(),
        if (auth.isLoggedIn) const SizedBox(height: 20),
        if (auth.isLoggedIn) AccountActions(auth: auth),
      ],
    );
  }
}