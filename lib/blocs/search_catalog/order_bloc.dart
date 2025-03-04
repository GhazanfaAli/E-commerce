// order_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<DocumentSnapshot> _products = [];
  int _count = 0;

  OrderBloc() : super(OrderInitial()) {
    on<SearchProducts>((event, emit) {
      final filteredProducts = _products.where((doc) {
        final title = doc['product_title'] ?? '';
        return title.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
        

      emit(OrderProductsFiltered(filteredProducts: filteredProducts, ));
    });
  }

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('products').get();
      _products = snapshot.docs;
      _count = _products.length;
      emit(OrderProductsLoaded(products: _products, count: _count));
    } catch (e) {
      emit(OrderError(message: "Error fetching products: $e"));
    }
  }
}
