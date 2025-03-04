// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      productUrl: json['productUrl'] as String? ?? 'empty...',
      producttitle: json['producttitle'] as String? ?? 'empty...',
      productDescription: json['productDescription'] as String? ?? 'empty...',
      productprice: json['productPrice'] as String? ?? 'empty...',
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productUrl': instance.productUrl,
      'producttitle': instance.producttitle,
      'productDescription': instance.productDescription,
      'productPrice': instance.productprice,
    };
