import 'package:equatable/equatable.dart';
import 'package:shoply_app/features/categories/domain/entities/category_entity.dart';
import 'package:shoply_app/features/products/domain/entities/product_entity.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final int? selectedCategoryId;
  final String searchQuery;

  const ProductLoaded({
    required this.products,
    required this.categories,
    this.selectedCategoryId,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [
        products,
        categories,
        selectedCategoryId,
        searchQuery,
      ];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}