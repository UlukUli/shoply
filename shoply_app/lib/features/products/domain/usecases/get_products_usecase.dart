import '../../../../core/errors/result.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  const GetProductsUseCase(this.repository);

  Future<Result<List<ProductEntity>>> call({
    int? categoryId,
    String? searchQuery,
  }) {
    return repository.getProducts(
      categoryId: categoryId,
      searchQuery: searchQuery,
    );
  }
}