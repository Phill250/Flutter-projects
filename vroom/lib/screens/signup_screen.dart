import 'package:flutter/material.dart';



class SignupScreen extends StatefulWidget {
 const SignupScreen({super.key});


 @override
 State<SignupScreen> createState() {
   return _SignupScreenState();
 }
}


class _SignupScreenState extends State<SignupScreen> {
 final _signupFormKey = GlobalKey<FormState>();
 final _firstNameController = TextEditingController();
 final _lastNameController = TextEditingController();
 final _emailController = TextEditingController();
 final _passwordController = TextEditingController();
 final _confirmPasswordController = TextEditingController();
 bool _hidePassword = true;
 bool _hideConfirmPassword = true;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up"),),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
        child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(Icons.person_2_outlined),
                border:OutlineInputBorder()
              ),
              validator: (value){
              if(value ==  null || value.isEmpty){
                return 'Enter first name';
              }
              return null;
              },
            ),

            SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.person_2_outlined),
                border:OutlineInputBorder()
              ),
              validator: (value){
              if(value ==  null || value.isEmpty){
                return 'Enter last name';
              }
              return null;
              },
            ),
            SizedBox(height: 16),


               TextFormField(
                 controller: _emailController,
                 keyboardType: TextInputType.emailAddress,
                 decoration: const InputDecoration(
                   labelText: 'Email',
                   prefixIcon: Icon(Icons.email_outlined),
                   border: OutlineInputBorder(),
                 ),
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Enter your email address';
                   }
                   if (!value.contains('@')) {
                     return 'Enter a valid email';
                   }
                   return null;
                 },
               ),
              
               const SizedBox(height: 16),


               TextFormField(
                 controller: _passwordController,
                 obscureText: _hidePassword,
                 decoration: InputDecoration(
                   labelText: 'Password',
                   prefixIcon: const Icon(Icons.lock_outline),
                   border: const OutlineInputBorder(),
                   suffixIcon: IconButton(
                     onPressed: () {
                       setState(() {
                         _hidePassword = !_hidePassword;
                       });
                     },
                     icon: Icon(_hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                   ),
                 ),
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Enter a password';
                   }
                   if (value.length < 6) {
                     return 'Password must be at least 6 characters';
                   }
                   return null;
                 },
               ),
              
               const SizedBox(height: 16),


               TextFormField(
                 controller: _confirmPasswordController,
                 obscureText: _hideConfirmPassword,
                 decoration: InputDecoration(
                   labelText: 'Confirm Password',
                   prefixIcon: const Icon(Icons.password_outlined),
                   border: const OutlineInputBorder(),
                   suffixIcon: IconButton(
                     onPressed: () {
                       setState(() {
                         _hideConfirmPassword = !_hideConfirmPassword;
                       });
                     },
                     icon: Icon(_hideConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                   ),
                 ),
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Confirm your password';
                   }
                   if (value != _passwordController.text) {
                     return 'Passwords do not match';
                   }
                   return null;
                 },
               ),
               SizedBox(height: 24),


              
               ElevatedButton(
                 onPressed: () {
                   if (_signupFormKey.currentState!.validate()) {
                    //Sign up
                   }
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepPurple,
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                   )
                 ),
                 child: const Text(
                   'Sign Up',
                   style: TextStyle(color: Colors.white, fontSize: 16),
                 ),
               ),
               
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text("Already have an account?"),
                   TextButton(
                     onPressed: () {
                      Navigator.pop(context);
          
                     },
                     child: const Text("Login"),
                   ),
                 ]
                   )




          ],
        
        ),
        ),
        ),
      )
    );
  }
  

 
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  
  }


}