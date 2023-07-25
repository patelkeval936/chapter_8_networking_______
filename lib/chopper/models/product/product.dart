import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';
// Product deserializeProduct(Map<String, dynamic> json) => Product.fromMap(json);
//
// List<Product> deserializeProductList(List l) =>
//     l.map((e) => Product.fromMap(e as Map<String, dynamic>)).toList();
//
// Map<String, dynamic> serializeProduct(Product object) => object.toMap();

@JsonSerializable()
class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
