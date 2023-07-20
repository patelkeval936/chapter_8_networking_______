// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      json['id'] as String,
      json['star'] as int,
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'id': instance.id,
      'star': instance.star,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Product',
      json,
      ($checkedConvert) {
        final val = Product(
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('ToPa', (v) => v as String?),
          visibleChhe: $checkedConvert('visible-chhe',
              (v) => $enumDecodeNullable(_$IsVisibleEnumMap, v)),
          rating: $checkedConvert(
              'rating',
              (v) => v == null
                  ? null
                  : Rating.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'name': 'ToPa', 'visibleChhe': 'visible-chhe'},
    );

const _$ProductFieldMap = <String, String>{
  'id': 'id',
  'name': 'ToPa',
  'priceHistory': 'price-history',
  'visibleChhe': 'visible-chhe',
  'rating': 'rating',
};

// ignore: unused_element
abstract class _$ProductPerFieldToJson {
  // ignore: unused_element
  static Object? id(String? instance) => instance;
  // ignore: unused_element
  static Object? name(String? instance) => instance;
  // ignore: unused_element
  static Object? priceHistory(Map<String, int>? instance) => instance;
  // ignore: unused_element
  static Object? visibleChhe(IsVisible? instance) =>
      _$IsVisibleEnumMap[instance];
  // ignore: unused_element
  static Object? rating(Rating? instance) => instance?.toJson();
}

Map<String, dynamic> _$ProductToJson(Product instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('ToPa', instance.name);
  writeNotNull('price-history', instance.priceHistory);
  writeNotNull('visible-chhe', _$IsVisibleEnumMap[instance.visibleChhe]);
  writeNotNull('rating', instance.rating?.toJson());
  return val;
}

const _$IsVisibleEnumMap = {
  IsVisible.yesBro: 'yes-Bro',
  IsVisible.noBro: 'noBro',
};
