import 'package:dio/dio.dart';

class MyTransformer extends Transformer{
  @override
  Future<String> transformRequest(RequestOptions options) async {
    print('inside transformer request');
    final dynamic data = options.data ?? '';
    BackgroundTransformer();
    SyncTransformer();
      return data.toString();
  }

  @override
  Future transformResponse(RequestOptions options, ResponseBody response) async{
    print('inside transform response');
   return response;
  }
}

