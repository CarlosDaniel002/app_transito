// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AplicarMulta extends StatefulWidget {
  const AplicarMulta({super.key});

  @override
  State<AplicarMulta> createState() => _AplicarMultaState();
}

class _AplicarMultaState extends State<AplicarMulta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicar Multa'),
      ),
    );
  }
}