import '../../../../core/errors/result.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Result<List<ProductEntity>>> getProducts({
    int? categoryId,
    String? searchQuery,
  });

  Future<Result<ProductEntity>> getProductById(int id);
}