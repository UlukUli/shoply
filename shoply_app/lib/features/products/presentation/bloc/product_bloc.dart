import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/errors/result.dart';
import 'package:shoply_app/features/categories/domain/entities/category_entity.dart';
import 'package:shoply_app/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:shoply_app/features/products/domain/usecases/get_products_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  List<CategoryEntity> _categories = [];
  int? _selectedCategoryId;
  String _searchQuery = '';

  ProductBloc({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(const ProductInitial()) {
    on<CatalogStarted>(_onCatalogStarted);
    on<CategorySelected>(_onCategorySelected);
    on<ProductsSearched>(_onProductsSearched);
  }

  Future<void> _onCatalogStarted(
    CatalogStarted event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());

    final categoriesResult = await getCategoriesUseCase();
    if (categoriesResult is Success<List<CategoryEntity>>) {
      _categories = categoriesResult.data;
    }

    await _fetchProducts(emit);
  }

  Future<void> _onCategorySelected(
    CategorySelected event,
    Emitter<ProductState> emit,
  ) async {
    _selectedCategoryId = event.categoryId;
    emit(const ProductLoading());
    await _fetchProducts(emit);
  }

  Future<void> _onProductsSearched(
    ProductsSearched event,
    Emitter<ProductState> emit,
  ) async {
    _searchQuery = event.query;
    await _fetchProducts(emit);
  }

  Future<void> _fetchProducts(Emitter<ProductState> emit) async {
    final result = await getProductsUseCase(
      categoryId: _selectedCategoryId,
      searchQuery: _searchQuery,
    );

    switch (result) {
      case Success(:final data):
        emit(
          ProductLoaded(
            products: data,
            categories: _categories,
            selectedCategoryId: _selectedCategoryId,
            searchQuery: _searchQuery,
          ),
        );
      case ErrorResult(:final failure):
        emit(ProductError(failure.message));
    }
  }
}