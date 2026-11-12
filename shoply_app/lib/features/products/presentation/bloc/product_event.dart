import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class CatalogStarted extends ProductEvent {
  const CatalogStarted();
}

class CategorySelected extends ProductEvent {
  final int? categoryId;

  const CategorySelected(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class ProductsSearched extends ProductEvent {
  final String query;

  const ProductsSearched(this.query);

  @override
  List<Object?> get props => [query];
}