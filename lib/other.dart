import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonEnum(fieldRename: FieldRename.pascal, valueField: 'visible-hoy-shake')
enum IsVisible {
  @JsonValue('yes-Bro')
  yesBro,
  @JsonValue('noBro')
  noBro
}

@JsonSerializable()
class Rating {
  final String id;
  final int star;

  Rating(this.id, this.star);

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.kebab,
  anyMap: false,
  checked: true,
  // constructor: 'jam',
  createFactory: true,
  createToJson: true,
  createFieldMap: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
  ignoreUnannotated: false,
  includeIfNull: false,
  createPerFieldToJson: true,
  converters: [ProductListConverter()],
)
class Product {
  final String? id;
  @JsonKey(name: 'ToPa')
  final String? name;
  @JsonKey(name: 'price-history', includeFromJson: false, includeToJson: true)
  final Map<String, int>? priceHistory;

  final IsVisible? visibleChhe;
  final Rating? rating;
  Product(
      {this.id, this.name, this.visibleChhe, this.priceHistory, this.rating});

  Product.jam(
      {this.id, this.name, this.visibleChhe, this.priceHistory, this.rating});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

class ProductListConverter
    extends JsonConverter<List<Product>, Iterable<Map<String, dynamic>>> {
  const ProductListConverter();

  @override
  List<Product> fromJson(Iterable<Map<String, dynamic>> json) {
    return json.map(Product.fromJson).toList();
  }

  @override
  Iterable<Map<String, dynamic>> toJson(List<Product> object) {
    return object.map((e) => e.toJson());
  }
}
