import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_store.g.dart';

@JsonEnum(alwaysCreate: true,valueField:'hello world')
enum StockMarketStatus {
  @JsonValue('value is open')
  open,
  @JsonValue('value is close')
  close
}

@JsonSerializable()
class Product {

  @JsonKey(unknownEnumValue: StockMarketStatus.close)
  StockMarketStatus status;

  Product(this.status);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}


void main(){
  Product product = Product.fromJson({'status' : 'value is open'});
  print(product.toJson());
}

