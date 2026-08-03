import 'package:flutter/material.dart';
import 'package:vroom/screens/login_screen.dart';
import 'package:vroom/screens/signup_screen.dart';
import 'package:vroom/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(fontFamily: 'Lobster Two'),
    );
  }
}
