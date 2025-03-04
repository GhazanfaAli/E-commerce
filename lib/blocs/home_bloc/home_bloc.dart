import 'package:bloc/bloc.dart';
import 'package:e_commerce/config/model/product.dart';
import 'package:e_commerce/respository/products/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce/config/data/response/api_response.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;
  
  HomeBloc({required this.productRepository}) : super(HomeState(productList: ApiResponse.loading())) {

    on<FetchedProduct>(fetchProductListApi);
  }
  
// Future<void> fetchProductListApi(FetchedProduct event, Emitter<HomeState> emit) async {
//   try {
//     await productRepository.fetchProductsList().then((value){
//       emit(state.copyWith(productList: ApiResponse.completed(value)));
//     });
    
//   } catch (error) {
//     emit(state.copyWith(productList: ApiResponse.error(error.toString())));
//   }
// }
Future<void> fetchProductListApi(FetchedProduct event, Emitter<HomeState> emit) async {
  emit(state.copyWith(productList: ApiResponse.loading())); // Emit loading state
  try {
    final products = await productRepository.fetchProductsList(categoryUrl:  event.categoryUrl);
    print('Fetched products: $products');
    emit(state.copyWith(productList: ApiResponse.completed(products)));
  } catch (error) {
    emit(state.copyWith(productList: ApiResponse.error(error.toString())));
    print('Error fetching products: $error');
  }
}


}



