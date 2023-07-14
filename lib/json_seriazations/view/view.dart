import 'package:chapter_8_networking/json_seriazations/store/product_store.dart';
import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductStore productStore = ProductStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Map<String, dynamic> json = {
                'products': [
                  {
                    'hello' : 'world',
                    'id': 1,
                    'name': 'product1',
                    'category': 'category1',
                    'price': 20.00,
                    'rating': {'id': '1', 'star': 5},
                  },
                  {
                    'id': 2,
                    'name': 'product2',
                    'category': 'category2',
                    'price': 200.00,
                    'rating': {'id': '2', 'star': 4},
                  },
                ]
              };
              print(ProductStore.fromJson(json).products.first.name);
              // print(ProductStore().toJson());
            },
            child: Text('hello world')),
      ),
    );
  }
}
