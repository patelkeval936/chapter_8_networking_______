import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart' as path;

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
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiResponse? apiResponse;
  Dio dio = Dio();

  void get() async {


    Uri url = Uri.https('fakestoreapi.com', '/products/1');
    // var response = await dio.getUri(url);
    var response = await dio.get('https://fakestoreapi.com/products/1');
    setState(() {
      apiResponse = ApiResponse(response.data.toString(), response.headers.toString(), response.statusCode.toString());
    });
    print('get Header is ${response.headers}');
    print('get response is ${response.data}');
  }

  Image? image;

  CancelToken cancelToken1 = CancelToken();
  CancelToken cancelToken2 = CancelToken();
  String? progress1;
  String? progress2;

  void getImage1() async {

    // Directory directory = await path.getApplicationDocumentsDirectory();

    var response = await dio.get(
      // 'https://sample-videos.com/img/Sample-jpg-image-30mb.jpg',
      'https://static.toiimg.com/thumb/resizemode-4,msid-101534099,width-800,height-450,imgv-75/101534099.jpg',
      cancelToken: cancelToken1,
      onReceiveProgress: (count, total) {
        setState(() {
          progress1 = ((count / total) * 100).toStringAsFixed(2);
        });
      },
    );

    // print(directory.path);
    //
    String data = response.data;
    print(data);
    //
    // dio.request('',options: Options());
    //
    // dio.interceptors;
    //
    // setState(() {
    //   image = response.data;
    // });
  }

  void getImage2() async {

    Directory directory = await path.getApplicationDocumentsDirectory();

    final file = File('${directory.path}/image.jpg');

    var response = await dio.download(
      'https://static.toiimg.com/thumb/resizemode-4,msid-101534099,width-800,height-450,imgv-75/101534099.jpg',
      // 'https://sample-videos.com/img/Sample-jpg-image-30mb.jpg',
      file.path,
      cancelToken: cancelToken2,
      onReceiveProgress: (count, total) {
        setState(() {
          progress2 = '${((count / total) * 100).toStringAsFixed(2)}';
        });
        print('on receive progress : ${((count / total) * 100).toStringAsFixed(2)}%');
      },
    );

    setState(() {
      image = Image.file(file);
    });

  }

  void uploadImageUsingMultiPart(Uint8List file) async {
    String apiKey = '472b8953adb0c8675ece88c89e08efde';
    //
    // final request = http.MultipartRequest('POST', Uri.parse('https://api.imgbb.com/1/upload'));
    //
    // Map<String, String> headers = {
    //   "Content-type": "multipart/form-data",
    //   'key' : apiKey,
    // };
    //
    // request.files.add(
    //     http.MultipartFile.fromBytes('file', file.toList())
    // );
    // request.headers.addAll(headers);6
    // final res = await request.send();
    // print(res.statusCode);
  }

  // void uploadImage(Uint8List file) async {
  //   String apiKey = '472b8953adb0c8675ece88c89e08efde';
  //   Uri uri = Uri.parse('https://api.imgbb.com/1/upload');
  //   print(uri.queryParametersAll);
  //   final res = await http.post(uri,
  //       body: {"key":apiKey,"image":base64Encode(file)}
  //       );
  //   print(res.statusCode);
  //
  //
  //
  //   final request = http.MultipartRequest(
  //       'POST', Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey')
  //
  //       // .replace(
  //       // queryParameters: {'key': '$apiKey'},
  //       // ),
  //       );
  //   Map<String, String> headers = {
  //     // "Authorization": "Bearer $token",
  //     "Content-type": "multipart/form-data"
  //   };
  //
  //   uint8ListTob64(file);
  //
  //   request.files.add(
  //     http.MultipartFile(
  //       'file',
  //       Stream.value(file),
  //       file.length,
  //       filename: 'filename.jpeg',
  //       // contentType: MediaType('image', 'jpeg'),
  //     ),
  //   );
  //   request.headers.addAll(headers);
  //   final res = await request.send();
  //   print(res.statusCode);
  // }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  void post() async {
    Uri url = Uri.https('fakestoreapi.com', '/products');
    var response = await dio.postUri(
      url,
      data: {'title': 'test product', 'description': 'desc', 'image': 'https://i.pravatar.cc', 'category': 'electronic'},
    );
    setState(() {
      apiResponse = ApiResponse(response.data.toString(), response.headers.toString(), response.statusCode.toString());
    });
    print('post Header is ${response.headers}');
    print('post response is ${response.data}');
  }

  void put() async {
    Uri url = Uri.https('fakestoreapi.com', '/products/5');
    var response = await dio.putUri(url, data: {
      'title': 'test product',
      'price': '13.5',
      // 'description': 'lorem ipsum set',
      'image': 'https://i.pravatar.cc',
      'category': 'electronic'
    });
    setState(() {
      apiResponse = ApiResponse(response.data.toString(), response.headers.toString(), response.statusCode.toString());
    });
    print('put Header is ${response.headers}');
    print('put response is ${response.data}');
  }

  void patch() async {
    Uri url = Uri.https('fakestoreapi.com', '/products/5');
    var response = await dio.patchUri(url, data: {
      'title': 'test product',
      'price': '13.5',
    });
    setState(() {
      apiResponse = ApiResponse(response.data.toString(), response.headers.toString(), response.statusCode.toString());
    });
    print('put Header is ${response.headers}');
    print('put response is ${response.data}');
  }

  void delete() async {
    Uri url = Uri.https('fakestoreapi.com', '/products/5');
    var response = await dio.deleteUri(url);
    setState(() {
      apiResponse = ApiResponse(response.data['title'].toString(), response.headers.toString(), response.statusCode.toString());
    });
    print('put Header is ${response.headers}');
    print('put response is ${response.data}');
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
                  onPressed: () {
                    // read();
                  },
                  child: const Text('Read')),
              ElevatedButton(
                  onPressed: () {
                    // readBytes();
                  },
                  child: const Text('Read Bytes')),
              ElevatedButton(
                  onPressed: () {
                    get();
                  },
                  child: const Text('Get')),

              image ?? Container(),
              Text(
                '${progress1 ?? ''} %',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  getImage1();
                },
                child: const Text('Get Image 1'),
              ),
              Text(
                '${progress2 ?? ''} %',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  getImage2();
                },
                child: const Text('Get Image2 - download and show'),
              ),

              ElevatedButton(
                  onPressed: () {
                    dio.close(force: true);
                  },
                  child: const Text('Close client')),

              ElevatedButton(
                  onPressed: () {
                    cancelToken1.cancel();
                  },
                  child: const Text('cancel Request1')),
              ElevatedButton(
                  onPressed: () {
                    cancelToken2.cancel();
                  },
                  child: const Text('cancel Request2')),
              ElevatedButton(
                  onPressed: () {
                    post();
                  },
                  child: const Text('Post')),
              ElevatedButton(
                  onPressed: () {
                    put();
                  },
                  child: const Text('Put')),
              ElevatedButton(
                  onPressed: () {
                    patch();
                  },
                  child: const Text('Patch')),
              ElevatedButton(
                  onPressed: () {
                    delete();
                  },
                  child: const Text('Delete')),
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
