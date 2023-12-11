import 'package:app_transito/models/VehiculoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgregarVehiculo extends StatefulWidget {
  const AgregarVehiculo({super.key});

  @override
  State<AgregarVehiculo> createState() => _AgregarVehiculoState();
}

class _AgregarVehiculoState extends State<AgregarVehiculo> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Vehiculo'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _placaController,
                decoration: const InputDecoration(labelText: 'Placa del vehiculo'),
              ),
              TextField(
                controller: _marcaController,
                decoration: const InputDecoration(labelText: 'Marca del vehiculo'),
              ),
              TextField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo del vehiculo'),
              ),
              TextField(
                controller: _anoController,
                decoration: const InputDecoration(
                  labelText: 'Año de Fabricación',
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
                controller: _colorController,
                decoration: const InputDecoration(labelText: 'Color del vehiculo'),
              ),
              const SizedBox(height: 16),
          
              ElevatedButton(
                onPressed: (){
                  _registrarVehiculo();
                    Navigator.of(context).pop();
                },
                    child: const Text('Registrar Vehiculo'),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> _registrarVehiculo() async {
    Vehiculo nuevoConductor = Vehiculo(
      placa: _placaController.text,
      marca: _marcaController.text,
      modelo: _modeloController.text,
      // ignore: unnecessary_cast
      anoFabricacion: date.year as int,
      color: _colorController.text
    );

    await _registrarVehiculoFirestore(nuevoConductor);
    _limpiarCampos();
  }

  Future<void> _registrarVehiculoFirestore(Vehiculo vehiculo) async {
    await _firestore.collection('Vehiculo').doc(vehiculo.placa).set({
      'placa': vehiculo.placa,
      'marca': vehiculo.marca,
      'modelo': vehiculo.modelo,
      'añoFabricacion': vehiculo.anoFabricacion,
      'color': vehiculo.color,
    });
  }

  void _limpiarCampos() {
    _anoController.clear();
    _colorController.clear();
    _placaController.clear();
    _marcaController.clear();
    _modeloController.clear();
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
