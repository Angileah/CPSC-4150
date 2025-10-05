import 'package:flutter/material.dart';
import 'dog_page.dart';

// The main function that runs the application
void main() {
  runApp(MyApp());
}

// The root widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DogPage(),
    );
  }
}
