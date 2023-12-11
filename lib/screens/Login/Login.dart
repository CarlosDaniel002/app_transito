// ignore_for_file: file_names, unnecessary_import, camel_case_types, prefer_final_fields, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';



class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String _email = "";
  String _pass = "";
  void _handleLogin() async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: _email, password: _pass);
      print('Usuario Logeado: ${userCredential.user!.email}');
      Navigator.of(context).pushNamed('/MenuWidget');
    } catch(e){
      print("Error al Logearse el usuario: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
          Padding(padding: const EdgeInsets.all(16), 
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text('Iniciar Sesión', textAlign: TextAlign.center),
                  const SizedBox(height: 100),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText:'Email'),
                    validator: (value){
                      if(value == null || value.isEmpty) {
                        return "Por favor ingrese su Email";
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText:'Contraseña'),
                    validator: (value){
                      if(value == null || value.isEmpty) {
                        return "Por favor ingrese su Contraseña";
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState(() {
                        _pass = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: (){
                  if (_formKey.currentState!.validate()){
                    _handleLogin();
                  }
                  }, child: const Text("Login")),
                  const SizedBox(height: 20),
                  const Text('¿No tienes una cuenta? registrate aquí'),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pushNamed('/Register');
                  }, child: const Text("Registrar")),
              ]
            ),
          )
        ),
      ),
    );
  }
}