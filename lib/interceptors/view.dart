import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chapter_8_networking/custom_interceptor.dart';
import 'package:chapter_8_networking/retrofit/product.dart';
import 'package:chapter_8_networking/retrofit/rest_client.dart';
import 'package:chapter_8_networking/retrofit/upload_download/image_rest_client.dart';
import 'package:chapter_8_networking/transformers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

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

  Dio dio = Dio();

  void get(int index) async {
    Response response = await dio.get('https://randomuser.me/api/',options: Options(extra: {'num' : index}));
    print(response.data);
  }

  @override
  void initState() {
    dio.interceptors.clear();
    dio.interceptors.add(CustomIntercepter());
    dio.interceptors.add(CustomIntercepter2());
    dio.interceptors.add(CustomIntercepter3());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    get(0);
                  },
                  child: const Text('Get')),
            ],
          ),
        ),
      ),
    );
  }
}

