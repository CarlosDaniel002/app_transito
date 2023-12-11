// ignore_for_file: use_key_in_widget_constructors, prefer_adjacent_string_concatenation, file_names

import 'dart:io';
import 'package:app_transito/services/select_image.dart';
import 'package:app_transito/services/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/Conductor.dart';

class AgregadorConductor extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AgregadorConductorState createState() => _AgregadorConductorState();
}

class _AgregadorConductorState extends State<AgregadorConductor> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _licenciaController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _nacimientoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  File? imagen_to_upload;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conductor Registrado'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Registrar Conductor',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _licenciaController,
                decoration: const InputDecoration(labelText: 'Licencia de Conducir'),
              ),
              // TextField(
              //   controller: _fotoController,
              //   decoration: const InputDecoration(labelText: 'URL de la Foto'),
              // ),
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: _nacimientoController,
                decoration: const InputDecoration(
                  labelText: 'Fecha de Nacimiento',
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                ),
                readOnly: true,
                onTap: () {
                  selectDate();
                  setState(() {
                    
                  });
                },
              ),
              TextField(
                controller: _direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
              ),
              TextField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
              ),
              const SizedBox(height: 16),
              imagen_to_upload != null ? Image.file(imagen_to_upload!): Container(
                margin: const EdgeInsets.all(10),
                height: 200,
                width: double.infinity,
                color: Colors.red,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [                
                  ElevatedButton(
                    onPressed: () async{
                    final imagen = await getImage();
                    setState(() {
                      imagen_to_upload = File(imagen!.path);
                    });
                  }, child: const Text("Seleccionar imagen")),
                  ElevatedButton(
                    onPressed: (){
                      _registrarConductor();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Registrar Conductor'),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              const Text(
                'Conductores Registrados',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> _registrarConductor() async {
    String foto = await uploadConductorImage(imagen_to_upload!);
    Conductor nuevoConductor = Conductor(
      licencia: _licenciaController.text,
      foto: foto,
      nombre: _nombreController.text,
      apellido: _apellidoController.text,
      nacimiento: date,
      direccion: _direccionController.text,
      telefono: int.parse(_telefonoController.text),
    );

    await _registrarConductorFirestore(nuevoConductor);
    _limpiarCampos();
  }

  Future<void> _registrarConductorFirestore(Conductor conductor) async {
    await _firestore.collection('conductores').doc(conductor.licencia).set({
      'licencia': conductor.licencia,
      'foto': conductor.foto,
      'nombre': conductor.nombre,
      'apellido': conductor.apellido,
      'nacimiento': conductor.nacimiento,
      'direccion': conductor.direccion,
      'telefono': conductor.telefono,
    });
  }

  void _limpiarCampos() {
    _licenciaController.clear();
    _fotoController.clear();
    _nombreController.clear();
    _apellidoController.clear();
    _nacimientoController.clear();
    _direccionController.clear();
    _telefonoController.clear();
    date = DateTime.now();
  }

  Future<void> selectDate() async{
    await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100)
    );
  }
}
