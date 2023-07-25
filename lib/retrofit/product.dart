
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product{

  int? id;
  String? title;
  double? price;
  String? category;
  Product(this.price,this.id, this.title, this.category);

  factory Product.fromJson(Map<String,dynamic> data) {
    print(data);

    return _$ProductFromJson(data);
  }

  toJson() => _$ProductToJson(this);

}