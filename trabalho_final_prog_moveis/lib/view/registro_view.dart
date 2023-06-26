import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trabalho_final_prog_moveis/components/teste_field_password.dart';
import 'package:trabalho_final_prog_moveis/constants/app_colors.dart';
import 'package:trabalho_final_prog_moveis/service/botao_firebase.dart';
import 'package:trabalho_final_prog_moveis/view/login_view.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:path/path.dart' as path;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _selectedImagePath;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _phoneNumberTextController = TextEditingController();

  Future<void> _selectImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final fileName = path.basename(pickedImage.path);
      final storageRef = storage.FirebaseStorage.instance.ref().child('user_images/$fileName');
      await storageRef.putFile(File(pickedImage.path));
      final imageUrl = await storageRef.getDownloadURL();
      setState(() {
        _selectedImagePath = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Cadastro",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.kPrimaryColor,
              AppColors.kTextStyle,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _selectImage,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: _selectedImagePath != null
                          ? DecorationImage(
                              image: NetworkImage(_selectedImagePath!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _selectedImagePath == null
                        ? Icon(
                            Icons.add_photo_alternate,
                            size: 40,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Toque na imagem para adicionar uma foto',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Email", Icons.person_outline, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Senha", Icons.lock_outlined, true, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Confirmar Senha", Icons.lock_outlined, true, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Número de Celular", Icons.phone, false, _phoneNumberTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Cadastrar", () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  ).then((value) {
                    print("Parabéns! Seu Cadastro foi realizado com sucesso");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
