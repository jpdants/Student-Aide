import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final_prog_moveis/view/registro_view.dart';
import 'package:trabalho_final_prog_moveis/view/tela_branca.dart';

import 'esqueceu_senha.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     // Do login here
  //   }
  // }

  void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      // Login bem-sucedido, navegue para a página de boas-vindas
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        print('Senha incorreta.');
      } else {
        print('Erro durante o login: ${e.message}');
      }
    } catch (e) {
      print('Erro durante o login: $e');
    }
  }
}


  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
    );
  }

  void _register() {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _forgotPassword,
                    child: Text('Forgot Password?'),
                  ),
                  Text('|'),
                  TextButton(
                    onPressed: _register,
                    child: Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ForgotPasswordPage extends StatefulWidget {
//   @override
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _email = '';
//   String _phoneNumber = '';

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Perform password recovery logic here
//       // You can access the entered email or phone number via _email and _phoneNumber variables

//       // Example password recovery logic:
//       print('Email: $_email');
//       print('Phone Number: $_phoneNumber');

//       // Reset form fields
//       setState(() {
//         _email = '';
//         _phoneNumber = '';
//       });

//       // Show a success dialog or navigate to a success page
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Password Recovery'),
//             content: Text('Instructions for password recovery have been sent to your email or phone number.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Forgot Password'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   // Perform email validation here
//                   // You can use regular expressions or any other validation logic
//                   // Return an error message if the email is invalid
//                   return null;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     _email = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   // Perform phone number validation here
//                   // You can use regular expressions or any other validation logic
//                   // Return an error message if the phone number is invalid
//                   return null;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     _phoneNumber = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: Text('Recover Password'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
