import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_final_prog_moveis/constants/app_colors.dart';
import 'package:trabalho_final_prog_moveis/view/home_page.dart';
import 'package:trabalho_final_prog_moveis/view/registro_view.dart';
import 'package:trabalho_final_prog_moveis/view/tela_branca.dart';

import '../components/teste_field_password.dart';
import 'esqueceu_senha.dart';
import 'gradiente_daltonico.dart'; // Importe a tela ColorAccessibilityScreen

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  Color _highlightColor = const Color.fromRGBO(47, 209, 197, 1);

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
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
      MaterialPageRoute(builder: (context) => ResetPassword()),
    );
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  void _openColorAccessibilityScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ColorAccessibilityScreen()),
    );
    if (result != null && result is Color) {
      setState(() {
        _highlightColor = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: Text('Realize seu login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logo("lib/assets/img/logo.png"),
                const SizedBox(
                  height: 80,
                ),
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
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(_highlightColor),
                  ),
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
                ListTile(
                  leading: Icon(Icons.accessibility),
                  title: Text('Acessibilidade de Cores'),
                  onTap: _openColorAccessibilityScreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
