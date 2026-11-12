import '../../../../core/errors/result.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  const GetCategoriesUseCase(this.repository);

  Future<Result<List<CategoryEntity>>> call() {
    return repository.getCategories();
  }
}