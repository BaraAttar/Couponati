import 'package:flutter/material.dart';
import 'package:my_app/features/auth/auth_controller.dart';
import 'package:my_app/generated/l10n.dart';

class LoggedInUserInfo extends StatelessWidget {
  final AuthController auth;

  const LoggedInUserInfo({
    super.key,
    required this.auth,
  });

  @override
  Widget build(BuildContext context) {
    final user = auth.user;
    final name = user?.firstName ?? S.of(context).user_default_name;
    final email = user?.email ?? '';

    return Row(
      children: [
        _UserAvatar(auth: auth),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[900],
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      size: 14,
                      color: Colors.green[700],
                    ),
                    const SizedBox(width: 5),
                    Text(
                      S.of(context).user_verified_account,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==================== Private Widget ====================

class _UserAvatar extends StatelessWidget {
  final AuthController auth;

  const _UserAvatar({
    required this.auth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: auth.isLoggedIn
                ? LinearGradient(
                    colors: [Colors.blue[400]!, Colors.purple[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: auth.isLoggedIn ? null : Colors.grey[300],
            boxShadow: auth.isLoggedIn
                ? [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: auth.isLoggedIn
              ? Center(
                  child: Text(
                    auth.user?.firstName?.substring(0, 1).toUpperCase() ?? '?',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              : const Icon(Icons.person_outline, size: 36, color: Colors.grey),
        ),
        if (auth.isLoggedIn)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
              ),
              child: const Icon(Icons.check, size: 12, color: Colors.white),
            ),
          ),
      ],
    );
  }
}