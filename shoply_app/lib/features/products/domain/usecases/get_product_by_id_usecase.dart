import '../../../../core/errors/result.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository repository;

  const GetProductByIdUseCase(this.repository);

  Future<Result<ProductEntity>> call(int id) {
    return repository.getProductById(id);
  }
}