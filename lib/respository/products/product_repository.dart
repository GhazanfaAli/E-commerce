import 'package:e_commerce/config/model/product.dart';


// abstract class ProductRepository {
//   Future<ProductModel>fetchProductsList();
// }

abstract class ProductRepository {
  Future<List<ProductModel>> fetchProductsList({String? categoryUrl});
}
