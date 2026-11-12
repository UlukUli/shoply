import '../../../../core/errors/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> loginDemo();

  Future<UserEntity?> getSavedUser();

  Future<void> logout();
}