part of 'stripe_bloc.dart';


class StripeEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
  
}

class fetchPayment extends StripeEvent {
  final String productName;
  final double price;
  final String orderStatus;

  fetchPayment({
    required this.productName,
    required this.price,
    required this.orderStatus,
  });

  @override
  List<Object?> get props => [productName, price, orderStatus];
}


