import 'package:dio/dio.dart';

class CustomIntercepter extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('${options.extra}     Request-Interceptor 1');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('${response.requestOptions.extra}      Response-Interceptor 1');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('inside ON ERROR 1 ${err.requestOptions.extra} ${err.error}');
    handler.next(err);
  }
}




class CustomIntercepter2 extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('${options.extra}     Request-Interceptor 2');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('${response.requestOptions.extra}     Response-Interceptor 2');

    handler.reject(DioException(requestOptions: response.requestOptions,message: 'theown exception'),true);
    // handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('inside ON ERROR 2 ${err.requestOptions.extra}');
    // handler.resolve(Response(requestOptions: RequestOptions()));
    handler.reject(DioException(requestOptions: err.requestOptions,message: 'theown exception1'));
    handler.next(err);
  }
}






class CustomIntercepter3 extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('${options.extra}     Request-Interceptor 3');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('${response.requestOptions.extra}     Response-Interceptor 3');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('inside ON ERROR 3 ${err.requestOptions.extra}');

    handler.next(err);
  }
}

