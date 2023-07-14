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

  late RestClient restClient;
  List<Product> posts = [];

  getProducts() async {
    posts = await restClient.getProducts();
    setState(() {
      posts;
    });
  }

  getProductsWithCategory() async {
    posts = await restClient.getProductsWithCategory('jewelery');
    setState(() {
      posts;
    });
  }

  createProduct() async {
    posts.add(
      await restClient.addedToBody({'title': 'test product', 'price': 13.5, 'id': 1, 'category': 'electronic'}),
    );
    setState(() {
      posts;
    });
  }

  formData() async {
    posts.add(
      await restClient.formData('title goes here','description goes here'),
    );
    setState(() {
      posts;
    });
  }

  @override
  void initState() {
    restClient = RestClient(dio..interceptors.add(LogInterceptor(responseBody: true,requestBody: true)));
    super.initState();
  }

  Image? image;
  double received = 0.0;
  Future<void> getImage() async {
    ImageRestClient client = ImageRestClient(Dio());
    HttpResponse<List<int>> response = await client.downloadFile((i, j) {
      setState(() {
        received = i * 100 / j;
      });
      print('$i,$j');
    });
    print(response.data);
    setState(() {
      image = Image.memory(Uint8List.fromList(response.data));
    });
    uploadImage(Uint8List.fromList(response.data));
  }

  Future<void> uploadImage(Uint8List list) async {
    print('inside upload image');
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true,requestBody: true));
    UploadImageClient uploadImageClient = UploadImageClient(dio);
    HttpResponse response = await uploadImageClient.uploadFile({'key': '89874052fad8103e839a2c97141a1a00', 'image': base64Encode(list)}, (p0, p1) {
      print('$p0 / $p1');
    });

    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              image ?? Container(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    ...posts.map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(e.id.toString()),
                              Text(e.price.toString()),
                              Text(e.title.toString()),
                              Text(e.category.toString()),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Text(received.toString()),
              ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: const Text('Get Image')),
              ElevatedButton(
                  onPressed: () {
                    getProducts();
                  },
                  child: const Text('Get')),
              ElevatedButton(
                  onPressed: () {
                    getProductsWithCategory();
                  },
                  child: const Text('Get with category')),
              ElevatedButton(
                  onPressed: () {
                    createProduct();
                  },
                  child: const Text('Create Product')),
              ElevatedButton(
                  onPressed: () {
                    formData();
                  },
                  child: const Text('form data')),
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
