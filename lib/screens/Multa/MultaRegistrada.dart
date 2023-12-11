// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_transito/models/Multa.dart';
class MultaRegistrada extends StatefulWidget {
  @override
  _MultaRegistradaState createState() => _MultaRegistradaState();
}

class _MultaRegistradaState extends State<MultaRegistrada> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _descripcionController = TextEditingController();
  File? imagen_to_upload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multa Registrada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder(
                future: _obtenerMultas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Multa> multas = snapshot.data as List<Multa>;
                    return ListView.builder(
                      itemCount: multas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(multas[index].motivo),
                          subtitle: Text(
                            'Fecha: ${multas[index].fecha}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            _mostrarDetallesMulta(multas[index]);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          _obtenerMultas;
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }


  Future<List<Multa>> _obtenerMultas() async {
      final QuerySnapshot multasSnapshot = await _firestore
          .collection('multas')
          .get();

      return multasSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Multa(
          id: doc.id,
          cedula: data['Cedula'] as String,
          placa: data['Placa'] as String,
          motivo: data['Motivo'] as String,
          evidencia: data['evidencia'] as String,
          comentario: data['comentario'] as String,
          fecha: (data['Fecha'] as Timestamp).toDate(),
          latitud: data['latitud'] as double,
          longitud: data['longitud'] as double,
        );
      }).toList();
  }

  void _mostrarDetallesMulta(Multa multa) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detalles de la Multa'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Descripción: ${multa.motivo}'),
              Text('Fecha: ${multa.fecha}'),
              Text('Latitud: ${multa.latitud}'),
              Text('Longitud: ${multa.longitud}'),
              Container(
                child: Image.network(multa.evidencia),
                margin: const EdgeInsets.all(10),
                height: 200,
                width: double.infinity,
                color: Colors.red,
              ),
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
}
