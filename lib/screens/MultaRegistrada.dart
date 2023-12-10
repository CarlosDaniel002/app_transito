// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MultaRegistrada extends StatefulWidget {
  @override
  _MultaRegistradaState createState() => _MultaRegistradaState();
}

class _MultaRegistradaState extends State<MultaRegistrada> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Geolocator _geolocator = Geolocator();

  MapController _mapController = MapController();
  List<Marker> _markers = [];
  final TextEditingController _descripcionController = TextEditingController();

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
            const Text(
              'Registrar Multa',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _registrarMulta,
              child: const Text('Registrar Multa'),
            ),
            const SizedBox(height: 32),
            const Text(
              'Multas Registradas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
                          title: Text(multas[index].descripcion),
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
            const Text(
              'Mapa de Multas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 200,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(37.7749, -122.4194),
                  zoom: 12,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: _markers,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registrarMulta() async {
    Position position = await Geolocator.getCurrentPosition();
    Multa nuevaMulta = Multa(
      id: '',
      descripcion: _descripcionController.text,
      fecha: DateTime.now(),
      latitude: position.latitude,
      longitude: position.longitude,
    );

    await _registrarMultaFirestore(nuevaMulta);
    _descripcionController.clear();
    _cargarMultas();
  }

  Future<void> _cargarMultas() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final QuerySnapshot multasSnapshot = await _firestore
          .collection('multas')
          .where('agenteId', isEqualTo: user.uid)
          .get();

      setState(() {
        _markers = multasSnapshot.docs.map((doc) {
          final multa = doc.data() as Map<String, dynamic>;
          final LatLng latLng = LatLng(
            multa['ubicacion']['latitude'],
            multa['ubicacion']['longitude'],
          );

          return Marker(
            width: 40.0,
            height: 40.0,
            point: latLng,
            builder: (context) => IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () {
                _mostrarDetallesMulta(Multa(
                  id: doc.id,
                  descripcion: multa['descripcion'],
                  fecha: (multa['fecha'] as Timestamp).toDate(),
                  latitude: multa['ubicacion']['latitude'],
                  longitude: multa['ubicacion']['longitude'],
                ));
              },
            ),
          );
        }).toList();
      });
    }
  }

  Future<List<Multa>> _obtenerMultas() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final QuerySnapshot multasSnapshot = await _firestore
          .collection('multas')
          .where('agenteId', isEqualTo: user.uid)
          .get();

      return multasSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Multa(
          id: doc.id,
          descripcion: data['descripcion'],
          fecha: (data['fecha'] as Timestamp).toDate(),
          latitude: data['ubicacion']['latitude'],
          longitude: data['ubicacion']['longitude'],
        );
      }).toList();
    }

    return [];
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
              Text('Descripción: ${multa.descripcion}'),
              Text('Fecha: ${multa.fecha}'),
              Text('Latitud: ${multa.latitude}'),
              Text('Longitud: ${multa.longitude}'),
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

  Future<void> _registrarMultaFirestore(Multa multa) async {
    final User? user = _auth.currentUser;

    if (user != null) {
      await _firestore.collection('multas').add({
        'descripcion': multa.descripcion,
        'fecha': multa.fecha,
        'ubicacion': {
          'latitude': multa.latitude,
          'longitude': multa.longitude,
        },
        'agenteId': user.uid,
      });
    }
  }
}

class Multa {
  String id;
  String descripcion;
  DateTime fecha;
  double latitude;
  double longitude;

  Multa({
    required this.id,
    required this.descripcion,
    required this.fecha,
    required this.latitude,
    required this.longitude,
  });
}