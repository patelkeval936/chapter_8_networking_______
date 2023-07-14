import 'dart:io';

import 'package:chapter_8_networking/retrofit/product.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class RestClient {

  factory RestClient(Dio dio) = _RestClient;

  @GET('/products/')
  Future<List<Product>> getProducts();

  @GET('/products/category/{category}')
  Future<List<Product>> getProductsWithCategory(@Path('category') String category);

  @POST('/products')
  @MultiPart()
  // @FormUrlEncoded()
  Future<Product> formData(@Field('title') String hello,@Field('category') String name);

  @POST('/products')
  Future<Product> addedToBody(@Body(nullToAbsent: true) Map<String,dynamic> data);

  @POST('/products')
  Future<Product> bodyField(@Field('address') List<String> hello,@Field() String name);

  @POST('/products')
  Future<Product> cancelRequest(@CancelRequest() cancelRequest);

  // @POST('/products')
  // Future<Product> createTaskFromFile(@Part(name: 'file.jpeg',fileName: 'filename',contentType: 'image/jpeg') File file);

  // @POST('/products')
  // @Headers(<String,dynamic>{
  //   "content-encoding": 'gzip',
  //   'content-type': 'application/font-woff'
  // })
  // Future<Product> headerSetting(@Header('hello') String hello,);

  //@header is for dynamically adding data to the header
  @POST('/products')
  Future<Product> addedToHeaderProperty(@Header('hello') String hello,@Header('hello1') String hello1);

}






