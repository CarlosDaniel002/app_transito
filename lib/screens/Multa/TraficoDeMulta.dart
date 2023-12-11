// ignore_for_file: file_names

import 'package:flutter/material.dart';
class TraficoDeMulta extends StatefulWidget {
  const TraficoDeMulta({super.key});

  @override
  State<TraficoDeMulta> createState() => _TraficoDeMultaState();
}

class _TraficoDeMultaState extends State<TraficoDeMulta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tráfico de multa'),
      ),
    );
  }
}