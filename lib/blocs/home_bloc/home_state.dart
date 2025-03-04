part of 'home_bloc.dart';

// import 'package:equatable/equatable.dart';
// import 'package:e_commerce/config/data/response/api_response.dart';
// import 'package:e_commerce/config/model/product.dart';

class HomeState extends Equatable {
  final ApiResponse<List<ProductModel>> productList;

  HomeState({required this.productList});

  HomeState copyWith({
    ApiResponse<List<ProductModel>>? productList,
  }) {
    return HomeState(
      productList: productList ?? this.productList,
    );
  }

  @override
  List<Object?> get props => [productList];
}
