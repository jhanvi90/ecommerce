import 'package:flutter/material.dart';
import 'package:ecommercee/screens/products.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ProductsScreen()
    );

  }
}

