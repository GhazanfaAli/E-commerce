import 'dart:convert';
import 'dart:io';
import 'package:e_commerce/config/data/base_api_service.dart';
import 'package:e_commerce/config/data/exception/app_exceptions.dart';
import 'package:e_commerce/config/model/product.dart';

import 'package:http/http.dart' as http;

class NetworkApiServices implements BaApiService {
  List<ProductModel> product_list = [];

  @override
  Future<dynamic> getApi(String url, {Map<String, String>? headers}) async {
    dynamic jsonResponse;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      ).timeout(const Duration(seconds: 20));
      jsonResponse = _handleResponse(response);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for(Map<String, dynamic> i in data){
          product_list.add(ProductModel.fromJson(i));
        }
      }
      
      else{
      return product_list;
      }
    } on SocketException {
      throw NetworkException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timed out');
    } catch (e) {
      throw FetchDataException('An unexpected error occurred: $e');
    }
    //return jsonResponse;
    return product_list;
  }

  dynamic _handleError(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw FetchDataException('Bad request: ${response.statusCode}');
      case 401:
        throw FetchDataException('Unauthorized: ${response.statusCode}');
      case 500:
        throw FetchDataException('Server error: ${response.statusCode}');
      default:
        throw FetchDataException('Error: ${response.statusCode}');
    }
  }

  @override
  Future<dynamic> postApi(String url, dynamic data, {Map<String, String>? headers}) async {
    dynamic jsonResponse;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers ?? {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      jsonResponse = _handleResponse(response);

    } on SocketException {
      throw NetworkException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timed out');
    } catch (e) {
      throw FetchDataException('An unexpected error occurred: $e');
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> putApi(String url, dynamic data, {Map<String, String>? headers}) async {
    dynamic jsonResponse;

    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers ?? {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      jsonResponse = _handleResponse(response);

    } on SocketException {
      throw NetworkException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timed out');
    } catch (e) {
      throw FetchDataException('An unexpected error occurred: $e');
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> deleteApi(String url, {Map<String, String>? headers}) async {
    dynamic jsonResponse;

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      ).timeout(const Duration(seconds: 10));

      jsonResponse = _handleResponse(response);

    } on SocketException {
      throw NetworkException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timed out');
    } catch (e) {
      throw FetchDataException('An unexpected error occurred: $e');
    }

    return jsonResponse;
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw FetchDataException('Bad request: ${response.statusCode}');
      case 401:
        throw FetchDataException('Unauthorized: ${response.statusCode}');
      case 500:
        throw FetchDataException('Server error: ${response.statusCode}');
      default:
        throw FetchDataException('Error: ${response.statusCode}');
    }
  }
}
