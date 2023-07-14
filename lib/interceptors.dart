import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'custom_interceptor.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class ApiResponse {
  String? response;
  String? header;
  String? responseCode;

  ApiResponse(this.response, this.header, this.responseCode);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage> {
  ApiResponse? apiResponse;

  Dio dio = Dio();

  Future<Response> get(int index) async {
    dio.interceptors.clear();
    dio.interceptors.add(CustomIntercepter());
    dio.interceptors.add(CustomIntercepter2());
    dio.interceptors.add(CustomIntercepter3());
    Response response = await dio.get('https://randomuser.me/api/',options: Options(extra: {'num' : index}));
    ApiResponse apiResponse = ApiResponse(response.data.toString(), response.headers.toString(), response.statusCode.toString());
    return response;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interceptor'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    FormetedText(apiResponse: 'Response Code : \n${apiResponse?.responseCode}\n\n'),
                    FormetedText(apiResponse: 'Response : \n${apiResponse?.response}\n\n'),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    for (int i = 1; i <= 1; i++) {
                      await Future.delayed(Duration(milliseconds: 500));
                      get(i);
                    }
                  },
                  child: const Text('Get')),
            ],
          ),
        ),
      ),
    );
  }
}

class FormetedText extends StatelessWidget {
  const FormetedText({
    super.key,
    required this.apiResponse,
  });

  final String? apiResponse;

  @override
  Widget build(BuildContext context) {
    return Text(
      apiResponse.toString().replaceAll(',', ',\n').replaceAll('{', '{\n').replaceAll('}', '\n}'),
      style: TextStyle(fontSize: 16),
    );
  }
}
