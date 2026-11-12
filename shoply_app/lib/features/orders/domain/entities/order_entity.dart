import 'package:equatable/equatable.dart';
import 'package:shoply_app/features/cart/domain/entities/cart_item_entity.dart';

class OrderEntity extends Equatable {
  final int id;
  final List<CartItemEntity> items;
  final double totalAmount;
  final String status;
  final String shippingAddress;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.shippingAddress,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        items,
        totalAmount,
        status,
        shippingAddress,
        createdAt,
      ];
}