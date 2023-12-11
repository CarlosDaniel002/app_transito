// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String? _email = _auth.currentUser!.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('App agente de tránsito de RD'),
      ),
      body:  Center(
        child: Text("Bienvenido: ${_email!}"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Trafico De Multa'),
              onTap: () {
                Navigator.of(context).pushNamed('/TraficoDeMulta');
              },
            ),
            ListTile(
              title: const Text('Consulta De Vehiculo Por Placa'),
              onTap: () {
                Navigator.of(context).pushNamed('/ConsultaVehiculo');
              },
            ),
            ListTile(
              title: const Text('Consulta de Conductor por licencia'),
              onTap: () {
                Navigator.of(context).pushNamed('/ConsultaConductor');
              },
            ),
            ListTile(
              title: const Text('Aplicar Multa'),
              onTap: () {
                Navigator.of(context).pushNamed('/AplicarMulta');
              },
            ),
            ListTile(
              title: const Text('Multas Registradas'),
              onTap: () {
                Navigator.of(context).pushNamed('/MultaRegistrada');
              },
            ),
            ListTile(
              title: const Text('Mapa De Multa'),
              onTap: () {
                Navigator.of(context).pushNamed('/MapaMulta');
              },
            ),
            ListTile(
              title: const Text('Noticias'),
              onTap: () {
                Navigator.of(context).pushNamed('/Noticias');
              },
            ),
            ListTile(
              title: const Text('Clima'),
              onTap: () {
                Navigator.of(context).pushNamed('/Clima');
              },
            ),
            ListTile(
              title: const Text('Horoscopo'),
              onTap: () {
                Navigator.of(context).pushNamed('/Horoscopo');
              },
            ),

            // ListTile(
            //   title: const Text('Agregar Conductor'),
            //   onTap: () {
            //     Navigator.of(context).pushNamed('/AgregadorConductor');
            //   },
            // ),
            ListTile(
              title: const Text('Sign out'),
              onTap: () {
                _auth.signOut();
                Navigator.of(context).pushNamed('/Login');
              },
            )
          ],
        ),
      ),
    );
  }
}