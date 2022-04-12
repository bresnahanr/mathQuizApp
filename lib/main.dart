import 'package:flutter/material.dart';
import './home.dart';

void main() {
  runApp(MathApp());
}

class MathApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue.shade100,
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
