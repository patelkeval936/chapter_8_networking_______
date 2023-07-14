import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'image_rest_client.g.dart';

// @RestApi(baseUrl: "https://www.phoca.cz/")
@RestApi(baseUrl: "https://media.istockphoto.com/id/1337232523/photo/high-angle-view-of-a-lake-and-forest.jpg?b=1&s=170667a&w=0&k=20&c=MMQAIpDombUQd_8FV9os3jLzza26-oqaOhO3AgUSt9k=")
abstract class ImageRestClient{

  factory ImageRestClient(Dio dio) = _ImageRestClient;

  // @POST('1/upload')
  // Future<Map<String,dynamic>> uploadFile(Uint8List image);

  // @GET("images/phocadownloadsite/phocadownload-category-view-bootstrap-mobile-mobile-view.png")
  @GET('')
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> downloadFile(@ReceiveProgress() void Function(int, int)? onReceiveProgress);

}

@RestApi(baseUrl: "https://api.imgbb.com/")
abstract class UploadImageClient{
  factory UploadImageClient(Dio dio) = _UploadImageClient;

  @POST('1/upload')
  @FormUrlEncoded()
  Future<dynamic> uploadFile(@Body(nullToAbsent: true) Map<String,dynamic> data,@SendProgress() void Function(int,int)? onUploadProgress);

}