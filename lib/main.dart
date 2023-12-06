import 'package:flutter/material.dart';
import 'package:app_transito/screens/Login.dart';
import 'package:app_transito/screens/Register.dart';
import 'package:app_transito/screens/Home.dart';
import 'package:app_transito/screens/TraficoDeMulta.dart';
import 'package:app_transito/screens/ConsultaVehiculo.dart';
import 'package:app_transito/screens/ConsultaConductor.dart';
import 'package:app_transito/screens/AplicarMulta.dart';
import 'package:app_transito/screens/MultaRegistrada.dart';
import 'package:app_transito/screens/MapaMulta.dart';
import 'package:app_transito/screens/Noticias.dart';
import 'package:app_transito/screens/Clima.dart';
import 'package:app_transito/screens/Horoscopo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App agente de tránsito de RD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 178, 227,0)),
      ),
      initialRoute: '/Login',
      routes: {
        '/home':(context) => const Home(),
        '/Login':(context) => const login(),
        '/Register': (context) => const Register(),
        '/TraficoDeMulta': (context) => const TraficoDeMulta(),
        '/ConsultaVehiculo': (context) => const ConsultaVehiculo(),
        '/ConsultaConductor': (context) => const ConsultaConductor(),
        '/AplicarMulta':(context) => const AplicarMulta(),
        '/MultaRegistrada':(context) => const MultaRegistrada(),
        '/MapaMulta':(context) => const MapaMulta(),
        '/Noticias':(context) => const Noticias(),
        '/Clima':(context) => const Clima(),
        '/Horoscopo':(context) => const Horoscopo()
      },
    );
  }
}


