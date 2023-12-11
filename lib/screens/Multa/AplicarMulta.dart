// ignore_for_file: file_names
import 'dart:io';
import 'package:app_transito/models/Multa.dart';
import 'package:app_transito/services/select_image.dart';
import 'package:app_transito/services/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AplicarMulta extends StatefulWidget {
  const AplicarMulta({super.key});

  @override
  State<AplicarMulta> createState() => _AplicarMultaState();
}

class _AplicarMultaState extends State<AplicarMulta> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _motivoController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();
  final TextEditingController latitudController = TextEditingController();
  final TextEditingController longitudController = TextEditingController();
  final TextEditingController fechacController = TextEditingController();
  late double _latitud;
  late double _longitud;
  File? imagen_to_upload;
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicar Multa'),
      ),body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Aplicar Multa',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'Licencia de Conducir'),
              ),
              TextField(
                controller: _cedulaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Cedula'),
              ),
              TextField(
                controller: _placaController,
                decoration: const InputDecoration(labelText: 'Placa del vehiculo'),
              ),
              TextField(
                controller: _motivoController,
                decoration: const InputDecoration(labelText: 'Motivo'),
              ),
              TextField(
                controller: comentarioController,
                decoration: const InputDecoration(labelText: 'Comentario'),
              ),
              TextField(
                controller: fechacController,
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
                controller: latitudController,
                 keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Latitud'),
                onChanged: (value) {
                    setState(() {
                      try {
                        final double parsedValued = double.parse(value);
                        setState(() {
                          _latitud = parsedValued;
                        });
                      } catch (e) {
                        print('Error al convertir a double $e');
                        setState(() {
                          _latitud = 0.0;
                        });
                      }
                    }
                  );
                },
              ),
              TextField(
                controller: longitudController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Longitud'),
                onChanged: (value) {
                    setState(() {
                      try {
                        final double parsedValued = double.parse(value);
                        setState(() {
                          _longitud = parsedValued;
                        });
                      } catch (e) {
                        print('Error al convertir a double $e');
                        setState(() {
                          _longitud = 0.0;
                        });
                      }
                    }
                  );
                },
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
                      _registrarMulta();
                      // Navigator.of(context).pop();
                    },
                    child: const Text('Registrar Conductor'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registrarMulta() async {
    String foto = await uploadConductorImage(imagen_to_upload!);
    Multa nuevaMulta = Multa(
      id: _idController.text,
      cedula: _cedulaController.text,
      placa: _placaController.text,
      motivo: _motivoController.text,
      evidencia: foto,
      fecha: date,
      latitud: _latitud,
      longitud: _longitud,
      comentario: comentarioController.text,
    );

    await _registrarMultaFirestore(nuevaMulta);
    _limpiarCampos();
  }

Future<void> _registrarMultaFirestore(Multa multa) async {
    await _firestore.collection('multas').doc(multa.id).set({
      'id': multa.id,
      'Cedula': multa.cedula,
      'Placa': multa.placa,
      'Motivo': multa.motivo,
      'Fecha': multa.fecha,
      'evidencia': multa.evidencia,
      'latitud': multa.latitud,
      'longitud': multa.longitud,
      'comentario' : multa.comentario
    });
  }
  void _limpiarCampos() {
    _idController.clear();
    _placaController.clear();
    _cedulaController.clear();
    _motivoController.clear();
    comentarioController.clear();
    latitudController.clear();
    longitudController.clear();
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