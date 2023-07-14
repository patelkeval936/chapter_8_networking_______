import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import '../serialization/product.dart';

part 'product_store.g.dart';

@JsonSerializable(anyMap: true)
class ProductStore extends _ProductStore with _$ProductStore {
  ProductStore();

  factory ProductStore.fromJson(Map<String, dynamic> json) => _$ProductStoreFromJson(json);

  Map<String, dynamic> toJson() => _$ProductStoreToJson(this);
}


abstract class _ProductStore with Store {

  @ProductListConverter()
  List<Product> products = [
    Product( 1, null, 'category1',29.30,Rating('1', 5)),
    Product(2, 'product2', 'category2',29.31,Rating('1', 5)),
    Product( 3, 'product3', 'category3',29.32,Rating('1', 5)),
    Product( 4, 'product4', 'category4',29.33,Rating('1', 5)),
    Product(5, 'product5', 'category5',29.33,Rating('1', 5)),
  ];

}
