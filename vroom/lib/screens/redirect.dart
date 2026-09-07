import 'package:flutter/material.dart';
import 'package:vroom/screens/home_screen.dart';
import 'package:vroom/screens/login_screen.dart';
import 'package:vroom/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class Redirect extends StatelessWidget{
  const Redirect({Super, Key});

  @override
  Widget build(BuildContext context){
    return Consumer<AuthViewModel>(builder:(context, AuthViewModel, _){
      var status = AuthViewModel.authStatus;

      switch(status){
        case AuthStatus.authenticated:
          return const HomeScreen();
        case AuthStatus.unauthenticated:
          return const LoginScreen();



      }
      
    },
    );

  }
}