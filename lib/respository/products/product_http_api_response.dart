import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commerce/config/app_url.dart';
import 'package:e_commerce/config/model/product.dart';
import 'package:e_commerce/respository/products/product_repository.dart';

class ProductHttpApiResponse implements ProductRepository {
 // final _apiServices = NetworkApiServices();

  @override
  Future<List<ProductModel>> fetchProductsList({String? categoryUrl}) async {
  final response = await http.get(Uri.parse(categoryUrl ?? AppUrl.productApi));

  if (response.statusCode == 200) {
    // Decode the JSON data as a list of maps
    final List<dynamic> jsonList = json.decode(response.body);
    
    // Map each JSON object in the list to a ProductModel
    return jsonList.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}}
