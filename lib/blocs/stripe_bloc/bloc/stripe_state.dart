part of 'stripe_bloc.dart';


class StripeState extends Equatable {

    final String productName;
    final String price;
    final String orderStatus;

    StripeState({ this.productName = '',  this.price = '', this.orderStatus = ''});

    StripeState copyWith({String? productName, String? price, String? orderStatus}){
      return StripeState(
        productName: productName ?? this.productName, 
        price: this.price, 
        orderStatus: this.orderStatus
        );
    }
    
      @override
      List<Object?> get props => [productName, price, orderStatus];

}
