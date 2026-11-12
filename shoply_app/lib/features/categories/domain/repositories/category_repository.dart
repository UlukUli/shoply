import '../../../../core/errors/result.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Result<List<CategoryEntity>>> getCategories();
}