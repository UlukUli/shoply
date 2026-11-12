import 'package:shoply_app/core/errors/result.dart';
import 'package:shoply_app/features/products/domain/entities/product_entity.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Result<List<CartItemEntity>>> getCartItems();
  Future<Result<List<CartItemEntity>>> addToCart(ProductEntity product);
  Future<Result<List<CartItemEntity>>> updateQuantity(int productId, int quantity);
  Future<Result<List<CartItemEntity>>> removeFromCart(int productId);
  Future<Result<void>> clearCart();
}