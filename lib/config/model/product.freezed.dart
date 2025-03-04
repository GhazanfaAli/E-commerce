// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'productUrl')
  String get productUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'producttitle')
  String get producttitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'productDescription')
  String get productDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'productPrice')
  String get productprice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'productUrl') String productUrl,
      @JsonKey(name: 'producttitle') String producttitle,
      @JsonKey(name: 'productDescription') String productDescription,
      @JsonKey(name: 'productPrice') String productprice});
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productUrl = null,
    Object? producttitle = null,
    Object? productDescription = null,
    Object? productprice = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productUrl: null == productUrl
          ? _value.productUrl
          : productUrl // ignore: cast_nullable_to_non_nullable
              as String,
      producttitle: null == producttitle
          ? _value.producttitle
          : producttitle // ignore: cast_nullable_to_non_nullable
              as String,
      productDescription: null == productDescription
          ? _value.productDescription
          : productDescription // ignore: cast_nullable_to_non_nullable
              as String,
      productprice: null == productprice
          ? _value.productprice
          : productprice // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
          _$ProductModelImpl value, $Res Function(_$ProductModelImpl) then) =
      __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'productUrl') String productUrl,
      @JsonKey(name: 'producttitle') String producttitle,
      @JsonKey(name: 'productDescription') String productDescription,
      @JsonKey(name: 'productPrice') String productprice});
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
      _$ProductModelImpl _value, $Res Function(_$ProductModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productUrl = null,
    Object? producttitle = null,
    Object? productDescription = null,
    Object? productprice = null,
  }) {
    return _then(_$ProductModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productUrl: null == productUrl
          ? _value.productUrl
          : productUrl // ignore: cast_nullable_to_non_nullable
              as String,
      producttitle: null == producttitle
          ? _value.producttitle
          : producttitle // ignore: cast_nullable_to_non_nullable
              as String,
      productDescription: null == productDescription
          ? _value.productDescription
          : productDescription // ignore: cast_nullable_to_non_nullable
              as String,
      productprice: null == productprice
          ? _value.productprice
          : productprice // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl implements _ProductModel {
  _$ProductModelImpl(
      {this.id = 0,
      @JsonKey(name: 'productUrl') this.productUrl = 'empty...',
      @JsonKey(name: 'producttitle') this.producttitle = 'empty...',
      @JsonKey(name: 'productDescription') this.productDescription = 'empty...',
      @JsonKey(name: 'productPrice') this.productprice = 'empty...'});

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: 'productUrl')
  final String productUrl;
  @override
  @JsonKey(name: 'producttitle')
  final String producttitle;
  @override
  @JsonKey(name: 'productDescription')
  final String productDescription;
  @override
  @JsonKey(name: 'productPrice')
  final String productprice;

  @override
  String toString() {
    return 'ProductModel(id: $id, productUrl: $productUrl, producttitle: $producttitle, productDescription: $productDescription, productprice: $productprice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productUrl, productUrl) ||
                other.productUrl == productUrl) &&
            (identical(other.producttitle, producttitle) ||
                other.producttitle == producttitle) &&
            (identical(other.productDescription, productDescription) ||
                other.productDescription == productDescription) &&
            (identical(other.productprice, productprice) ||
                other.productprice == productprice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, productUrl, producttitle,
      productDescription, productprice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(
      this,
    );
  }
}

abstract class _ProductModel implements ProductModel {
  factory _ProductModel(
          {final int id,
          @JsonKey(name: 'productUrl') final String productUrl,
          @JsonKey(name: 'producttitle') final String producttitle,
          @JsonKey(name: 'productDescription') final String productDescription,
          @JsonKey(name: 'productPrice') final String productprice}) =
      _$ProductModelImpl;

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'productUrl')
  String get productUrl;
  @override
  @JsonKey(name: 'producttitle')
  String get producttitle;
  @override
  @JsonKey(name: 'productDescription')
  String get productDescription;
  @override
  @JsonKey(name: 'productPrice')
  String get productprice;
  @override
  @JsonKey(ignore: true)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
