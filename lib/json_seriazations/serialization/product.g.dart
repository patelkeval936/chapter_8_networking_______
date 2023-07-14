// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['id'] as int?,
      json['name'] as String?,
      json['category'] as String?,
      (json['price'] as num?)?.toDouble(),
      Rating.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'price': instance.price,
      'rating': instance.rating.toJson(),
    };

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      json['id'] as String,
      json['star'] as int,
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'id': instance.id,
      'star': instance.star,
    };
