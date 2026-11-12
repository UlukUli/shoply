import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/app_theme.dart';
import '../features/authentication/presentation/bloc/auth_bloc.dart';
import '../features/authentication/presentation/bloc/auth_event.dart';
import '../features/authentication/presentation/bloc/auth_state.dart';
import '../features/cart/presentation/bloc/cart_bloc.dart';
import '../features/cart/presentation/bloc/cart_event.dart';
import '../features/orders/presentation/bloc/order_bloc.dart';
import '../features/products/presentation/bloc/product_bloc.dart';
import 'injection_container.dart';
import 'routes.dart';

class ShoplyApp extends StatelessWidget {
  const ShoplyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(const AuthCheckRequested()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => sl<ProductBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => sl<CartBloc>()..add(const CartStarted()),
        ),
        BlocProvider<OrderBloc>(
          create: (_) => sl<OrderBloc>(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            appRouter.go('/home');
          } else if (state is AuthUnauthenticated) {
            appRouter.go('/login');
          }
        },
        child: MaterialApp.router(
          title: 'Shoply',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}