// order_state.dart
part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderProductsLoaded extends OrderState {
  final List<DocumentSnapshot> products;
  final int count;

  OrderProductsLoaded({required this.products, required this.count});
}

class OrderProductsFiltered extends OrderState {
  final List<DocumentSnapshot> filteredProducts;

  OrderProductsFiltered({required this.filteredProducts});
}

class OrderError extends OrderState {
  final String message;

  OrderError({required this.message});
}
