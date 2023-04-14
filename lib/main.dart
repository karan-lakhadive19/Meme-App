import 'package:flutter/material.dart';
import 'package:meme/screens/meme.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Meme(),
      debugShowCheckedModeBanner: false,
    );
  }
}