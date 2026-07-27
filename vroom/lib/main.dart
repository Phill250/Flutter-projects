import 'package:flutter/material.dart';
import 'package:vroom/screens/login_screen.dart';
import 'package:vroom/screens/signup_screen.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vroom',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple, 
      ),
      home: const SignupScreen(), 
    );
  }
}
