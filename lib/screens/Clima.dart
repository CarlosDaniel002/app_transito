import 'package:flutter/material.dart';

class Clima extends StatefulWidget {
  const Clima({super.key});

  @override
  State<Clima> createState() => _ClimaState();
}

class _ClimaState extends State<Clima> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima'),
      ),
    );
  }
}