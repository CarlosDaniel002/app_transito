// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ConsultaVehiculo extends StatefulWidget {
  const ConsultaVehiculo({super.key});

  @override
  State<ConsultaVehiculo> createState() => _ConsultaVehiculoState();
}

class _ConsultaVehiculoState extends State<ConsultaVehiculo> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
        appBar: AppBar(
          title: const Text('Consulta de Vehiculos'),
        ),
      );
  }
}