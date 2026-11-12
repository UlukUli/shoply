import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final int categoryId;
  final String categoryName;
  final int stock;
  final double rating;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
    this.stock = 10,
    this.rating = 4.8,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        imageUrl,
        categoryId,
        categoryName,
        stock,
        rating,
      ];
}