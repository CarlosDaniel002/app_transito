// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MapaMulta extends StatefulWidget {
  const MapaMulta({super.key});

  @override
  State<MapaMulta> createState() => _MapaMultaState();
}

class _MapaMultaState extends State<MapaMulta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Multas'),
      ),
    );
  }
}