// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/Conductor.dart';

class ConsultaConductor extends StatefulWidget {
  const ConsultaConductor({Key? key}) : super(key: key);

  @override
  State<ConsultaConductor> createState() => _ConsultaConductorState();
}

class _ConsultaConductorState extends State<ConsultaConductor> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Conductor? _conductor;  
  final TextEditingController _licenciaController = TextEditingController();

  // Referencia a la colección "conductores" en Firestore
  
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
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                onPressed: () {
                  if(_conductor != null) {
                    _queryConductor(_licenciaController.text);
                    _mostrarDetallesConductor(_conductor!);
                  }
                },
                child: const Text('Consultar'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                onPressed: () {
                    Navigator.of(context).pushNamed('/AgregadorConductor');
                  },
                  child: const Text('Agregar Conductor'),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
            const SizedBox(height: 16.0),
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
                              'Fecha de Nacimiento: ${conductores[index].nacimiento}',
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
              const SizedBox(height: 16.0),
              // Text('Foto: ${conductor.foto}'),
              Container(
                margin: const EdgeInsets.all(10),
                height: 200,
                width: double.infinity,
                color: Colors.red,
                child: Image.network(conductor.foto),
              ),
              const SizedBox(height: 16.0),
              Text('Nombre: ${conductor.nombre} ${conductor.apellido}'),
              const SizedBox(height: 16.0),
              Text('Fecha de Nacimiento: ${conductor.nacimiento}'),
              const SizedBox(height: 16.0),
              Text('Dirección: ${conductor.direccion}'),
              const SizedBox(height: 16.0),
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
}
