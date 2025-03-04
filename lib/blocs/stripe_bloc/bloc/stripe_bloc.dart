import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/services/stripe_service/stripe_service.dart';


part 'stripe_event.dart';
part 'stripe_state.dart';


class StripeBloc extends Bloc<StripeEvent, StripeState> {
  StripeBloc() : super(StripeState()) {
    on<fetchPayment>(_showStripeData);
  }

  void _showStripeData(fetchPayment event, Emitter<StripeState> emit) async {
    emit(state.copyWith(
      productName: event.productName,
      price: event.price.toString(),
      orderStatus: event.orderStatus,
    ));

    await StripeServices.instance.makePayment(
      amount: (event.price * 100).toInt(),
      currency: 'usd',
      productName: event.productName,
    );
  }
}
