import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(
    explicitToJson: true,
    createToJson: true,
    checked: false,
    // constructor: 'hello_constructor',
    createFactory: true,
    createFieldMap: false,
    createPerFieldToJson: false,
    includeIfNull: true,
    anyMap: false,
    fieldRename: FieldRename.snake,
    genericArgumentFactories: false,
    disallowUnrecognizedKeys: false,
    ignoreUnannotated: true,
    converters: []
)
class Product {
  @JsonKey(
    name: 'id',
    includeIfNull: false,
    disallowNullValue: true,
    includeFromJson: true,
  )
  int? id;
  @JsonKey(name: 'name', required: true,)
  String? name;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'rating')
  Rating rating;

  Product(this.id, this.name, this.category, this.price, this.rating);

  Product.hello_constructor(this.id, this.name, this.category, this.price, this.rating);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Rating {
  final String id;
  final int star;

  Rating(this.id, this.star);

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

class ProductListConverter extends JsonConverter<List<Product>, List<Map<String, dynamic>>> {
  const ProductListConverter();

  @override
  List<Product> fromJson(List<Map<String, dynamic>> json) {
    return json.map((e) => Product.fromJson(e)).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<Product> products) {
    return products.map((e) => e.toJson()).toList();
  }
}
