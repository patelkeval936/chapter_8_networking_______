// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name'],
    disallowNullValues: const ['id'],
  );
  return Product(
    json['id'] as int?,
    json['name'] as String?,
    json['category'] as String?,
    (json['price'] as num?)?.toDouble(),
    Rating.fromJson(json['rating'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['category'] = instance.category;
  val['price'] = instance.price;
  val['rating'] = instance.rating.toJson();
  return val;
}

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      json['id'] as String,
      json['star'] as int,
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'id': instance.id,
      'star': instance.star,
    };
