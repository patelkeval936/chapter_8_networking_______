// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      $enumDecode(_$StockMarketStatusEnumMap, json['status'],
          unknownValue: StockMarketStatus.close),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'status': _$StockMarketStatusEnumMap[instance.status]!,
    };

const _$StockMarketStatusEnumMap = {
  StockMarketStatus.open: 'value is open',
  StockMarketStatus.close: 'value is close',
};
