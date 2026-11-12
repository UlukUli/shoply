import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/errors/result.dart';
import '../../domain/usecases/cart_usecases.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final AddToCartUseCase addToCartUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.getCartItemsUseCase,
    required this.addToCartUseCase,
    required this.updateCartQuantityUseCase,
    required this.removeFromCartUseCase,
    required this.clearCartUseCase,
  }) : super(const CartInitial()) {
    on<CartStarted>(_onCartStarted);
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemQuantityUpdated>(_onCartItemQuantityUpdated);
    on<CartItemRemoved>(_onCartItemRemoved);
    on<CartCleared>(_onCartCleared);
  }

  Future<void> _onCartStarted(
    CartStarted event,
    Emitter<CartState> emit,
  ) async {
    emit(const CartLoading());
    final result = await getCartItemsUseCase();
    switch (result) {
      case Success(:final data):
        emit(CartLoaded(data));
      case ErrorResult(:final failure):
        emit(CartError(failure.message));
    }
  }

  Future<void> _onCartItemAdded(
    CartItemAdded event,
    Emitter<CartState> emit,
  ) async {
    final result = await addToCartUseCase(event.product);
    switch (result) {
      case Success(:final data):
        emit(CartLoaded(data));
      case ErrorResult(:final failure):
        emit(CartError(failure.message));
    }
  }

  Future<void> _onCartItemQuantityUpdated(
    CartItemQuantityUpdated event,
    Emitter<CartState> emit,
  ) async {
    final result =
        await updateCartQuantityUseCase(event.productId, event.quantity);
    switch (result) {
      case Success(:final data):
        emit(CartLoaded(data));
      case ErrorResult(:final failure):
        emit(CartError(failure.message));
    }
  }

  Future<void> _onCartItemRemoved(
    CartItemRemoved event,
    Emitter<CartState> emit,
  ) async {
    final result = await removeFromCartUseCase(event.productId);
    switch (result) {
      case Success(:final data):
        emit(CartLoaded(data));
      case ErrorResult(:final failure):
        emit(CartError(failure.message));
    }
  }

  Future<void> _onCartCleared(
    CartCleared event,
    Emitter<CartState> emit,
  ) async {
    final result = await clearCartUseCase();
    switch (result) {
      case Success():
        emit(const CartLoaded([]));
      case ErrorResult(:final failure):
        emit(CartError(failure.message));
    }
  }
}