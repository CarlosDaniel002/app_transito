// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/VehiculoModel.dart';

class ConsultaVehiculo extends StatefulWidget {
  const ConsultaVehiculo({super.key});

  @override
  State<ConsultaVehiculo> createState() => _ConsultaVehiculoState();
}

class _ConsultaVehiculoState extends State<ConsultaVehiculo> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Vehiculo? _vehiculo;  
  final TextEditingController _placaController = TextEditingController();
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    _obtenerVehiculos;
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
        appBar: AppBar(
          title: const Text('Consulta de Vehiculos'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _placaController,
              decoration: const InputDecoration(labelText: 'Introducir la placa del vehiculo'),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                onPressed: () {
                  if(_vehiculo != null) {
                    _queryConductor(_placaController.text);
                    _mostrarDetallesVehiculo(_vehiculo!);
                  }
                },
                child: const Text('Consultar'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                onPressed: () {
                    Navigator.of(context).pushNamed('/AgregarVehiculo');
                  },
                  child: const Text('Agregar Vehiculo'),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
                child: FutureBuilder(
                  future: _obtenerVehiculos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Vehiculo> vehiculo = snapshot.data as List<Vehiculo>;
                      return ListView.builder(
                        itemCount: vehiculo.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Placa: ${vehiculo[index].placa}'),
                            subtitle: Text(
                              'Marca: ${vehiculo[index].marca} ${vehiculo[index].modelo}\n' +
                              'Año de fabricacion: ${vehiculo[index].anoFabricacion}',
                            ),
                            onTap: () {
                              _mostrarDetallesVehiculo(vehiculo[index]);
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

  final CollectionReference _vehiculoesCollection =
      FirebaseFirestore.instance.collection('Vehiculo');

  Future<void> _queryConductor(String placa) async {
    try {
      // Consulta Firestore para obtener datos del conductor
      var snapshot = await _vehiculoesCollection.where('placa', isEqualTo: placa).get();

      if (snapshot.docs.isNotEmpty) {
        // Tomar el primer documento, ya que se espera que la licencia sea única
        var conductorData = snapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          _vehiculo = Vehiculo(
            placa: conductorData['placa'],
            marca: conductorData['marca'],
            modelo: conductorData['modelo'],
            anoFabricacion: conductorData['anioFabricacion'],
            color: conductorData['color'],
          );
        });
      } else {
        // Limpiar el conductor si no se encuentra
        setState(() {
          _vehiculo = null;
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
void _mostrarDetallesVehiculo(Vehiculo vehiculo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detalles del Vehiculo'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Placa: ${vehiculo.placa}'),
              const SizedBox(height: 16.0),
              Text('Marca: ${vehiculo.marca} ${vehiculo.marca}'),
              const SizedBox(height: 16.0),
              Text('Modelo: ${vehiculo.modelo}'),
              const SizedBox(height: 16.0),
              Text('Año de fabricación: ${vehiculo.anoFabricacion}'),
              const SizedBox(height: 16.0),
              Text('Color: ${vehiculo.color}'),
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
  Future<List<Vehiculo>> _obtenerVehiculos() async {
    QuerySnapshot conductoresSnapshot =
        await _firestore.collection('Vehiculo').get();
    return conductoresSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      // ignore: unnecessary_null_comparison
      if(data.isEmpty || data == null) {
        return Vehiculo(
          placa: 'No Encotrada', 
          marca: 'No Encontrada', 
          modelo: 'No Encontrado', 
          anoFabricacion: 0000, 
          color: 'No Encontrado');
      }
      
      return Vehiculo(
        placa: data['placa'],
        marca: data['marca'],
        modelo: data['modelo'],
        anoFabricacion: data['añoFabricacion'],
        color: data['color'],
      );
    }).toList();
}  
}
