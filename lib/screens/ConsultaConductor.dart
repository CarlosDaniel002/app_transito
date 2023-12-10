// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Conductor.dart';

class ConsultaConductor extends StatefulWidget {
  const ConsultaConductor({Key? key}) : super(key: key);

  @override
  State<ConsultaConductor> createState() => _ConsultaConductorState();
}

class _ConsultaConductorState extends State<ConsultaConductor> {
  Conductor? _conductor;
  final TextEditingController _licenciaController = TextEditingController();

  // Referencia a la colección "conductores" en Firestore
  final CollectionReference _conductoresCollection =
      FirebaseFirestore.instance.collection('conductores');

  Future<void> _queryConductor(String license) async {
    try {
      // Consulta Firestore para obtener datos del conductor
      var snapshot = await _conductoresCollection.where('licencia', isEqualTo: license).get();

      if (snapshot.docs.isNotEmpty) {
        // Tomar el primer documento, ya que se espera que la licencia sea única
        var conductorData = snapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          _conductor = Conductor(
            licencia: conductorData['licencia'],
            foto: conductorData['foto'],
            nombre: conductorData['nombre'],
            apellido: conductorData['apellido'],
            nacimiento: conductorData['nacimiento'].toDate(),
            direccion: conductorData['direccion'],
            telefono: conductorData['telefono'],
          );
        });
      } else {
        // Limpiar el conductor si no se encuentra
        setState(() {
          _conductor = null;
        });
        _mostrarMensaje('Conductor no encontrado.');
      }
    } catch (e) {
      // Ignorar errores y mostrar mensaje
      print('Error al consultar conductor: $e');
      _mostrarMensaje('Error al consultar conductor.');
    }
  }

  void _mostrarMensaje(String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mensaje'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Conductor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _licenciaController,
              decoration: const InputDecoration(labelText: 'Licencia de Conducir'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _queryConductor(_licenciaController.text);
              },
              child: const Text('Consultar'),
            ),
            const SizedBox(height: 16.0),
            if (_conductor != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mostrar la información del conductor aquí
                  Image.network(_conductor!.foto),
                  Text('Nombre: ${_conductor!.nombre} ${_conductor!.apellido}'),
                  Text('Fecha de Nacimiento: ${_conductor!.nacimiento.toLocal()}'),
                  Text('Dirección: ${_conductor!.direccion}'),
                  Text('Teléfono: ${_conductor!.telefono}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
