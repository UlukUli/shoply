import 'package:go_router/go_router.dart';
import '../features/authentication/presentation/pages/login_page.dart';
import '../features/authentication/presentation/pages/register_page.dart';
import '../features/cart/presentation/pages/cart_page.dart';
import '../features/orders/presentation/pages/orders_page.dart';
import '../features/products/domain/entities/product_entity.dart';
import '../features/products/presentation/pages/product_detail_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import 'main_shell_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainShellPage(),
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) {
        final product = state.extra as ProductEntity;
        return ProductDetailPage(product: product);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);