import 'package:freezed_annotation/freezed_annotation.dart';


part 'product.g.dart';
part 'product.freezed.dart';

@freezed
class ProductModel with _$ProductModel{
  factory ProductModel({
   @Default(0) int id,
   @Default('empty...') @JsonKey(name: 'productUrl') String productUrl,
   @Default('empty...') @JsonKey(name: 'producttitle') String producttitle,
   @Default('empty...') @JsonKey(name: 'productDescription') String productDescription,
   @Default('empty...') @JsonKey(name: 'productPrice') String productprice
  }) = _ProductModel;
 
 
 factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
