import 'package:flutter/material.dart';
import 'package:vroom/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

 

  
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("assets/images/logo.png", width: 160, height: 160),

                SizedBox(height: 16),

                Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your email';
                    }

                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 50),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                      icon: Icon(
                        _hidePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your paswword';
                    }
                    return null;
                  },
                  obscureText: _hidePassword,
                ),

                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: (
                    
                  ) {
                    if(_loginFormKey.currentState!.validate()){

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8)
                    )

                  ),
                  child: Text('Login',
                  style: TextStyle(color: Colors.white, fontFamily: 'Playfair Display')),
                ),
                SizedBox(height: 20),
                Row(
                mainAxisAlignment:MainAxisAlignment.center,
                  children: [Text("Not yet registered?"),
                TextButton(onPressed: (){
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  
                  
                }, child: Text("Sign up"))],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}