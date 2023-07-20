import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  void read() async {

    Uri url = Uri.https('fakestoreapi.com', '/products/1');
    var response = await http.read(url);
    print(response);
  }

  void readBytes() async {
    Uri url = Uri.https('fakestoreapi.com', '/products/1');
    var response = await http.readBytes(url);
    print(response);
    print(String.fromCharCodes(response));
  }

  void get() async {
    Uri url = Uri.https('fakestoreapi.com', '/products/1');
    var response = await http.get(url);
    setState(() {
      apiResponse = ApiResponse(response.body, response.headers.toString(), response.statusCode.toString());
    });
    print('get Header is ${response.headers}');
    print('get response is ${response.body}');
  }

  Image? image;
  int total =0;
  int received =0;

  void getImage() async {

    Uri url = Uri.https('sample-videos.com', '/img/Sample-jpg-image-5mb.jpg');
    var response = await http.get(url);

    print('get Header is ${response.headers}');
    print('get response is ${response.bodyBytes}');

    setState(() {
      image = Image.memory(response.bodyBytes);
    });

    File file = File.fromRawPath(response.bodyBytes);

    uploadImageUsingMultiPart(response.bodyBytes);
  }

  void uploadImageUsingMultiPart(Uint8List file) async {

    String apiKey = '472b8953adb0c8675ece88c89e08efde';

    final request = http.MultipartRequest('POST', Uri.parse('https://api.imgbb.com/1/upload'));

    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'key' : apiKey,
    };

    request.files.add(
        http.MultipartFile.fromBytes('file', file.toList())
    );

    request.headers.addAll(headers);
    final res = await request.send();
    print(res.statusCode);
  }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }

  void post() async {
    Uri url = Uri.https('fakestoreapi.com', '/products');
    var response =
    await http.post(url, body: {'title': 'test product', 'description': 'desc', 'image': 'https://i.pravatar.cc', 'category': 'electronic'});
    setState(() {
      apiResponse = ApiResponse(response.body, response.headers.toString(), response.statusCode.toString());
    });
    print('post Header is ${response.headers}');
    print('post response is ${response.body}');
  }

  void put() async {
    Uri url = Uri.https('fakestoreapi.com', '/products/5');
    var response = await http.put(url, body: {
      'title': 'test product',
      'price': '13.5',
      // 'description': 'lorem ipsum set',
      'image': 'https://i.pravatar.cc',
      'category': 'electronic'
    });
    setState(() {
      apiResponse = ApiResponse(response.body, response.headers.toString(), response.statusCode.toString());
    });
    print('put Header is ${response.headers}');
    print('put response is ${response.body}');
  }

  void patch() async {
    Uri url = Uri.https('fakestoreapi.com', '/products/5');
    var response = await http.patch(url, body: {
      'title': 'test product',
      'price': '13.5',
    });
    setState(() {
      apiResponse = ApiResponse(response.body, response.headers.toString(), response.statusCode.toString());
    });
    print('put Header is ${response.headers}');
    print('put response is ${response.body}');
  }

  void delete() async {
    Uri url = Uri.https('fakestoreapi.com', '/products/5');
    var response = await http.delete(url);
    setState(() {
      apiResponse = ApiResponse(response.body, response.headers.toString(), response.statusCode.toString());
    });
    print('put Header is ${response.headers}');
    print('put response is ${response.body}');
  }


  void getImageWithProgress() async {

    Uri url = Uri.https('sample-videos.com', '/img/Sample-jpg-image-10mb.jpg');

    List<int> imageData = [];

   http.Client client =  http.Client();

    http.StreamedResponse response = await client.send(http.Request('GET',url));

    setState(() {
      total = response.contentLength ?? 0;
    });

    response.stream.listen((value) {
      imageData.addAll(value);
      setState(() {
        received = imageData.length;
      });
    }).onDone(() {
      print(imageData.length);
      print(imageData);
      print((Uint8List.fromList(imageData)));
      setState(() {
        image = Image.memory(Uint8List.fromList(imageData));
      });
      uploadImageWithProgress(imageData);
      },
    );
}

  void uploadImage(Uint8List file) async {
    String apiKey = '89874052fad8103e839a2c97141a1a00';
    Uri uri = Uri.parse('https://api.imgbb.com/1/upload');
    print(uri.queryParametersAll);
    final res = await http.post(uri,
        body: {"key":apiKey,"image":base64Encode(file)}
    );
    print(res.statusCode);

    final request = http.MultipartRequest(
        'POST', Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey')

      // .replace(
      // queryParameters: {'key': '$apiKey'},
      // ),
    );
    Map<String, String> headers = {
      // "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data"
    };

    uint8ListTob64(file);

    request.files.add(
      http.MultipartFile(
        'file',
        Stream.value(file),
        file.length,
        filename: 'filename.jpeg',
        // contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    // final res = await request.send();
    print(res.statusCode);
  }

  void uploadImageWithProgress(List<int> imageData) async {

    print('uploading....');

    String apiKey = '89874052fad8103e839a2c97141a1a00';

    Uri uri = Uri.parse('https://api.imgbb.com/1/upload');

    http.Client client = http.Client();

    http.StreamedResponse response  = await client.send(http.MultipartRequest("POST",uri)..fields.addAll({"key":apiKey,"image":base64Encode(imageData)}));
    final total = imageData.length;

    // response.stream.transform(streamTransformer);

    num uploaded = 0;
    response.stream.listen((value) {
      uploaded= uploaded + value.length;
      print("$total ${uploaded}");
    }).onDone(() {
      print('upload completed');
      print('status code ' + response.statusCode.toString());
    });

    // final res = await http.post(uri,
    //     body: {"key":apiKey,"image":base64Encode(file)}
    // );
    // print(res.statusCode);

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
              Text('$received/$total'),
              ElevatedButton(
                  onPressed: () {
                    getImageWithProgress();
                  },
                  child: const Text('Get Image with Progress')),
              ElevatedButton(
                  onPressed: () {
                    read();
                  },
                  child: const Text('Read')),
              ElevatedButton(
                  onPressed: () {
                    readBytes();
                  },
                  child: const Text('Read Bytes')),
              ElevatedButton(
                  onPressed: () {
                    get();
                  },
                  child: const Text('Get')),
              image ?? Container(),
              ElevatedButton(
                onPressed: () {
                  getImage();
                },
                child: const Text('Get Image'),
              ),
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
