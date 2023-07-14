// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductStore _$ProductStoreFromJson(Map json) => ProductStore()
  ..products = const ProductListConverter()
      .fromJson(json['products'] as List<Map<String, dynamic>>);

Map<String, dynamic> _$ProductStoreToJson(ProductStore instance) =>
    <String, dynamic>{
      'products': const ProductListConverter().toJson(instance.products),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on _ProductStore, Store {
  @override
  String toString() {
    return '''

    ''';
  }
}
