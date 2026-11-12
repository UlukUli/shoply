import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoply_app/app/injection_container.dart';
import 'package:shoply_app/core/network/dio_client.dart';
import 'package:shoply_app/core/theme/app_theme.dart';
import 'package:shoply_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:shoply_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:shoply_app/features/authentication/presentation/bloc/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDemoMode = sl<DioClient>().isDemoMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state is AuthAuthenticated ? state.user : null;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor:
                            AppTheme.primaryColor.withValues(alpha: 0.12),
                        child: Text(
                          (user?.name.isNotEmpty == true)
                              ? user!.name[0].toUpperCase()
                              : 'S',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? 'Покупатель Shoply',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.email ?? 'demo@shoply.app',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: (isDemoMode
                                        ? Colors.amber
                                        : const Color(0xFF10B981))
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                isDemoMode
                                    ? 'Демо-режим (локально)'
                                    : 'Подключено к Spring Boot API',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDemoMode
                                      ? const Color(0xFFB45309)
                                      : const Color(0xFF059669),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.receipt_long_outlined,
                        color: AppTheme.primaryColor,
                      ),
                      title: const Text('История заказов'),
                      subtitle: const Text('Статусы и детали покупок'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.push('/orders'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(
                        Icons.shopping_cart_outlined,
                        color: AppTheme.primaryColor,
                      ),
                      title: const Text('Корзина покупок'),
                      subtitle: const Text('Выбранные товары к оформлению'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.push('/cart'),
                    ),
                    const Divider(height: 1),
                    const ListTile(
                      leading: Icon(
                        Icons.info_outline_rounded,
                        color: AppTheme.textSecondaryColor,
                      ),
                      title: Text('О приложении'),
                      subtitle: Text('Shoply E-Commerce · Версия 1.0.0'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthLogoutRequested());
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.errorColor,
                  side: const BorderSide(color: AppTheme.errorColor),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Выйти из аккаунта'),
              ),
            ],
          );
        },
      ),
    );
  }
}