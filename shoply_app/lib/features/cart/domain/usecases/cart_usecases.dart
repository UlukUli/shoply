import 'package:shoply_app/core/errors/result.dart';
import 'package:shoply_app/features/products/domain/entities/product_entity.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repository;
  const GetCartItemsUseCase(this.repository);

  Future<Result<List<CartItemEntity>>> call() => repository.getCartItems();
}

class AddToCartUseCase {
  final CartRepository repository;
  const AddToCartUseCase(this.repository);

  Future<Result<List<CartItemEntity>>> call(ProductEntity product) =>
      repository.addToCart(product);
}

class UpdateCartQuantityUseCase {
  final CartRepository repository;
  const UpdateCartQuantityUseCase(this.repository);

  Future<Result<List<CartItemEntity>>> call(int productId, int quantity) =>
      repository.updateQuantity(productId, quantity);
}

class RemoveFromCartUseCase {
  final CartRepository repository;
  const RemoveFromCartUseCase(this.repository);

  Future<Result<List<CartItemEntity>>> call(int productId) =>
      repository.removeFromCart(productId);
}

class ClearCartUseCase {
  final CartRepository repository;
  const ClearCartUseCase(this.repository);

  Future<Result<void>> call() => repository.clearCart();
}