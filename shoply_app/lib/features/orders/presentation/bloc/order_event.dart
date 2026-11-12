import 'package:equatable/equatable.dart';
import 'package:shoply_app/features/cart/domain/entities/cart_item_entity.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class OrdersStarted extends OrderEvent {
  const OrdersStarted();
}

class OrderCreated extends OrderEvent {
  final List<CartItemEntity> items;
  final double totalAmount;
  final String shippingAddress;

  const OrderCreated({
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
  });

  @override
  List<Object?> get props => [items, totalAmount, shippingAddress];
}