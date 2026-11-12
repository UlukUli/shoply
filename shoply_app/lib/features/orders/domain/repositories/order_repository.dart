import 'package:shoply_app/core/errors/result.dart';
import 'package:shoply_app/features/cart/domain/entities/cart_item_entity.dart';
import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Result<List<OrderEntity>>> getOrders();

  Future<Result<OrderEntity>> createOrder({
    required List<CartItemEntity> items,
    required double totalAmount,
    required String shippingAddress,
  });
}