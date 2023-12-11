// ignore_for_file: prefer_const_constructors, duplicate_import

import 'package:app_transito/screens/Conductor/Agregarconductor.dart';
import 'package:app_transito/screens/Home/menu_widget.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:app_transito/screens/Login/Login.dart';
import 'package:app_transito/screens/Register/Register.dart';
import 'package:app_transito/screens/Home/Home.dart';
import 'package:app_transito/screens/Multa/TraficoDeMulta.dart';
import 'package:app_transito/screens/Vehiculo/ConsultaVehiculo.dart';
import 'package:app_transito/screens/Conductor/ConsultaConductor.dart';
import 'package:app_transito/screens/Multa/AplicarMulta.dart';
import 'package:app_transito/screens/Multa/MultaRegistrada.dart';
import 'package:app_transito/screens/Multa/MapaMulta.dart';
import 'package:app_transito/screens/Noticia/Noticias.dart';
import 'package:app_transito/screens/Clima/Clima.dart';
import 'package:app_transito/screens/Horoscopo/Horoscopo.dart';
import 'package:app_transito/screens/Conductor/Agregarconductor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
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
        '/MultaRegistrada': (context) => MultaRegistrada(),
        '/MapaMulta':(context) => const MapaMulta(),
        '/Noticias':(context) => const Noticias(),
        '/Clima':(context) => const Clima(),
        '/Horoscopo':(context) => const Horoscopo(),
        '/AgregadorConductor':(context) => AgregadorConductor(),
        '/MenuWidget':(context) => MenuWidget()
      },
    );
  }
}

