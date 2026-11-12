import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoply_app/core/theme/app_theme.dart';
import 'package:shoply_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:shoply_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:shoply_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:shoply_app/features/cart/presentation/bloc/cart_state.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const CatalogStarted());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoply'),
        actions: [
          IconButton(
            tooltip: 'Мои заказы',
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: () => context.push('/orders'),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final count = state is CartLoaded ? state.totalItemsCount : 0;
              return IconButton(
                tooltip: 'Корзина',
                onPressed: () => context.push('/cart'),
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    if (count > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppTheme.errorColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Выйти',
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthLogoutRequested());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск товаров...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                          context
                              .read<ProductBloc>()
                              .add(const ProductsSearched(''));
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
                context.read<ProductBloc>().add(ProductsSearched(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading || state is ProductInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProductError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductBloc>()
                                  .add(const CatalogStarted());
                            },
                            child: const Text('Повторить'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is ProductLoaded) {
                  return Column(
                    children: [
                      if (state.categories.isNotEmpty)
                        SizedBox(
                          height: 48,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length + 1,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                final isSelected =
                                    state.selectedCategoryId == null;
                                return ChoiceChip(
                                  label: const Text('Все'),
                                  selected: isSelected,
                                  onSelected: (_) {
                                    context
                                        .read<ProductBloc>()
                                        .add(const CategorySelected(null));
                                  },
                                );
                              }
                              final category = state.categories[index - 1];
                              final isSelected =
                                  state.selectedCategoryId == category.id;
                              return ChoiceChip(
                                label: Text(category.name),
                                selected: isSelected,
                                onSelected: (_) {
                                  context
                                      .read<ProductBloc>()
                                      .add(CategorySelected(category.id));
                                },
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: state.products.isEmpty
                            ? const Center(
                                child: Text(
                                  'Товары не найдены',
                                  style: TextStyle(
                                    color: AppTheme.textSecondaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : GridView.builder(
                                padding: const EdgeInsets.all(16),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.68,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: state.products.length,
                                itemBuilder: (context, index) {
                                  final product = state.products[index];
                                  return ProductCard(
                                    product: product,
                                    onTap: () => context.push(
                                      '/product',
                                      extra: product,
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}