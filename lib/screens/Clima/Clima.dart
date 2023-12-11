// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Clima extends StatefulWidget {
  const Clima({super.key});

  @override
  State<Clima> createState() => _ClimaState();
}

class _ClimaState extends State<Clima> {
  String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo,DO&appid=96d229af3e0cc12c39095846f05861ba&units=metric&lang=es';
  
  Map<String, dynamic> weatherData = {};

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }
  
 Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // Check if weatherData is null or empty
  // ignore: unnecessary_null_comparison
  if (weatherData == null || weatherData.isEmpty) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima'),
      ),
      body: Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }

  String temperature = weatherData['main']['temp'].toString();
  String weatherDescription = weatherData['weather'][0]['description'];
  String countryname = weatherData['name'].toString();
  
  return Scaffold(
    appBar: AppBar(
      title: const Text('Clima'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://img.freepik.com/vector-premium/icono-clima-dibujo-nube-su-expresion_583131-106.jpg?w=2000",
            width: 400,
            height: 400,
          ),
          const SizedBox(height: 16),
          Text(
            'Temperatura: $countryname',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            'Temperatura: $temperature°C',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            'Clima: $weatherDescription',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
  );
  }
}