import 'dart:async';

void main() async {
  print('Start!!');
  // print(await doSomething());
  // print(await doSomethingElse());
  print(await twoPlusThree());
}

Future<String> doSomething() {
  final Completer<String> completer = Completer<String>();

  Timer(const Duration(seconds: 5), () {
    print('Do Something!! 1');
    // completer.completeError('this is error');
    completer.complete('Complete!!');
    print('Do Something!! 2');
  });

  print('outside timer');
  return completer.future;
}


Future<int> twoPlusThree(){
  Completer<int> completer = Completer<int>();

  Timer(Duration(seconds: 5),() async{
    completer.complete(2+3);
    await Future.delayed(Duration(seconds: 5));
    print('after future');
  },);

  return completer.future;
}

Future<String> doSomethingElse() {
  Future<String> future = Future.delayed(Duration(seconds: 5), () => 'hello world');
  return future;
}

// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       theme: ThemeData.dark(),
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   void asyncTask(){
//     Completer();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Network'),
//       ),
//       body: Center(
//         child: const Text('Hello World'),
//       ),
//     );
//   }
// }
