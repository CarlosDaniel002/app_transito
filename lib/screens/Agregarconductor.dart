
// ignore_for_file: use_key_in_widget_constructors, prefer_adjacent_string_concatenation, file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Conductor.dart';
import 'package:intl/intl.dart';

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
            TextField(
              controller: _fotoController,
              decoration: const InputDecoration(labelText: 'URL de la Foto'),
            ),
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
              decoration: const InputDecoration(labelText: 'Fecha de Nacimiento'),
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
            ElevatedButton(
              onPressed: _registrarConductor,
              child: const Text('Registrar Conductor'),
            ),
            const SizedBox(height: 32),
            const Text(
              'Conductores Registrados',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder(
                future: _obtenerConductores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Conductor> conductores = snapshot.data as List<Conductor>;
                    return ListView.builder(
                      itemCount: conductores.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Licencia: ${conductores[index].licencia}'),
                          subtitle: Text(
                            'Nombre: ${conductores[index].nombre} ${conductores[index].apellido}\n' +
                            'Fecha de Nacimiento: ${_formatFecha(conductores[index].nacimiento)}',
                          ),
                          onTap: () {
                            _mostrarDetallesConductor(conductores[index]);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registrarConductor() async {
    Conductor nuevoConductor = Conductor(
      licencia: _licenciaController.text,
      foto: _fotoController.text,
      nombre: _nombreController.text,
      apellido: _apellidoController.text,
      nacimiento: _parseCustomDate(_nacimientoController.text),
      direccion: _direccionController.text,
      telefono: int.parse(_telefonoController.text),
    );

    await _registrarConductorFirestore(nuevoConductor);
    _limpiarCampos();
  }

  Future<List<Conductor>> _obtenerConductores() async {
    QuerySnapshot conductoresSnapshot =
        await _firestore.collection('conductores').get();

    return conductoresSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Conductor(
        licencia: data['licencia'],
        foto: data['foto'],
        nombre: data['nombre'],
        apellido: data['apellido'],
        nacimiento: (data['nacimiento'] as Timestamp).toDate(),
        direccion: data['direccion'],
        telefono: data['telefono'],
      );
    }).toList();
  }

  void _mostrarDetallesConductor(Conductor conductor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detalles del Conductor'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Licencia: ${conductor.licencia}'),
              Text('Foto: ${conductor.foto}'),
              Text('Nombre: ${conductor.nombre} ${conductor.apellido}'),
              Text('Fecha de Nacimiento: ${_formatFecha(conductor.nacimiento)}'),
              Text('Dirección: ${conductor.direccion}'),
              Text('Teléfono: ${conductor.telefono}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
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
  }





  DateTime _parseCustomDate(String dateString) {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length != 3) {
      throw const FormatException('Invalid date format');
    }

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }

  String _formatFecha(DateTime fecha) {
    return DateFormat('dd/MM/yyyy').format(fecha);
  }
}
