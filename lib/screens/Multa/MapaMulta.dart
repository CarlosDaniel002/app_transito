// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unused_field

import 'package:app_transito/models/Multa.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapaMulta extends StatefulWidget {
  const MapaMulta({super.key});

  @override
  State<MapaMulta> createState() => _MapaMultaState();
}

class _MapaMultaState extends State<MapaMulta> {
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
        title: const Text('Mapa de Multas'),
      ),body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(18.54284, -69.86083),
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

            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Multas Registradas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
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
          ],
        ), 
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cargarMultas();
        },
        child: const Icon(Icons.refresh),
        ),
    );
  }

  Future<void> _cargarMultas() async {
      final QuerySnapshot multasSnapshot = await _firestore
          .collection('multas')
          .get();

      setState(() {
        _markers = multasSnapshot.docs.map((doc) {
          final multa = doc.data() as Map<String, dynamic>;
          final LatLng latLng = LatLng(
            multa['latitud'],
            multa['longitud'],
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
                  cedula: multa['Cedula'],
                  placa: multa['Placa'],
                  motivo: multa['Motivo'],
                  fecha: (multa['Fecha'] as Timestamp).toDate(),
                  evidencia: multa['evidencia'],
                  latitud: multa['latitud'],
                  longitud: multa['longitud'],
                  comentario: multa['comentario']
                ));
              },
            ),
          );
        }).toList();
      });
    
  }

  Future<List<Multa>> _obtenerMultas() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot multasSnapshot = await _firestore
          .collection('multas').get();

      return multasSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Multa(
            id: doc.id,
            cedula: data['Cedula'],
            placa: data['Placa'],
            motivo: data['Motivo'],
            fecha: (data['Fecha'] as Timestamp).toDate(),
            evidencia: data['evidencia'],
            latitud: data['latitud'],
            longitud: data['longitud'],
            comentario: data['comentario']
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
              Text('Licencia: ${multa.id}'),
              const SizedBox(height: 16.0),
              // Text('Foto: ${conductor.foto}'),
              Text('Cedula: ${multa.cedula}'),
              const SizedBox(height: 16.0),
              Text('Placa: ${multa.placa}'),
              Container(
                margin: const EdgeInsets.all(10),
                height: 200,
                width: double.infinity,
                color: Colors.red,
                child: Image.network(multa.evidencia),
              ),
              const SizedBox(height: 16.0),
              Text('Motivo: ${multa.motivo}'),
              const SizedBox(height: 16.0),
              Text('Fecha: ${multa.fecha}'),
              const SizedBox(height: 16.0),
              Text('Latitud: ${multa.latitud}'),
              const SizedBox(height: 16.0),
              Text('Longitud: ${multa.longitud}'),
              const SizedBox(height: 16.0),
              Text('Comentario: ${multa.comentario}'),
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
