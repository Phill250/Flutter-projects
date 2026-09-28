import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vroom/screens/home_screen.dart';
import 'package:vroom/screens/login_screen.dart';
import 'package:vroom/model/cart.dart';
import 'package:vroom/screens/redirect.dart';
import 'package:vroom/viewmodel/auth_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> CartModel()),
      ChangeNotifierProvider(create: (context) => AuthViewModel()),

  
    ],
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Redirect(),
      theme: ThemeData(fontFamily: 'Space Mono'),
    );
  }
}












