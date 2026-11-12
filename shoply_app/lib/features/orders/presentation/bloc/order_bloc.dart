import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/errors/result.dart';
import '../../domain/usecases/order_usecases.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersUseCase getOrdersUseCase;
  final CreateOrderUseCase createOrderUseCase;

  OrderBloc({
    required this.getOrdersUseCase,
    required this.createOrderUseCase,
  }) : super(const OrderInitial()) {
    on<OrdersStarted>(_onOrdersStarted);
    on<OrderCreated>(_onOrderCreated);
  }

  Future<void> _onOrdersStarted(
    OrdersStarted event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderLoading());
    final result = await getOrdersUseCase();
    switch (result) {
      case Success(:final data):
        emit(OrdersLoaded(data));
      case ErrorResult(:final failure):
        emit(OrderError(failure.message));
    }
  }

  Future<void> _onOrderCreated(
    OrderCreated event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderLoading());
    final result = await createOrderUseCase(
      items: event.items,
      totalAmount: event.totalAmount,
      shippingAddress: event.shippingAddress,
    );

    switch (result) {
      case Success(:final data):
        emit(OrderCreateSuccess(data));
        final listResult = await getOrdersUseCase();
        if (listResult is Success) {
          emit(OrdersLoaded((listResult as Success).data));
        }
      case ErrorResult(:final failure):
        emit(OrderError(failure.message));
    }
  }
}