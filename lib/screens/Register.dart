import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String _email = "";
  String _pass = "";
  void _handleSignup() async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: _email, password: _pass);
      print('Usuario Creado: ${userCredential.user!.email}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario Creado correctamente'))
      );
    } catch(e){
      print("Error al crear el usuario: $e");
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
                  const Text('Registrate', textAlign: TextAlign.center),
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
                      _handleSignup();
                    }
                  }, child: const Text("Registrar")),
                  const Text('¿Tienes una cuenta? Inicia sesión aquí'),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pushNamed('/Login');
                  }, child: const Text("Iniciar sesión")),
              ]
            ),
          )
        ),
      ),
    );
  }
}