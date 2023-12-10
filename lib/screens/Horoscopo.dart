// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Horoscopo extends StatefulWidget {
  const Horoscopo({super.key});

  @override
  State<Horoscopo> createState() => _HoroscopoState();
}

class _HoroscopoState extends State<Horoscopo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horoscopo'),
      ),
    );
  }
}