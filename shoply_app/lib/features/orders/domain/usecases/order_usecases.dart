import 'package:shoply_app/core/errors/result.dart';
import 'package:shoply_app/features/cart/domain/entities/cart_item_entity.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrdersUseCase {
  final OrderRepository repository;
  const GetOrdersUseCase(this.repository);

  Future<Result<List<OrderEntity>>> call() => repository.getOrders();
}

class CreateOrderUseCase {
  final OrderRepository repository;
  const CreateOrderUseCase(this.repository);

  Future<Result<OrderEntity>> call({
    required List<CartItemEntity> items,
    required double totalAmount,
    required String shippingAddress,
  }) {
    return repository.createOrder(
      items: items,
      totalAmount: totalAmount,
      shippingAddress: shippingAddress,
    );
  }
}