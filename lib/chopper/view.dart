import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

import 'repository.dart';

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
              ElevatedButton(
                  onPressed: () async {
                    Response response = await ApiService.create().getProducts();
                    print(response.error);
                    print(response.bodyBytes);
                    print(response.body);
                    print(response.props);
                    print(response.statusCode);
                    print(response.headers);
                    print(response.isSuccessful);
                  },
                  child: const Text('request')),
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
