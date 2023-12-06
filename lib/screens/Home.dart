import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App agente de tránsito de RD'),
      ),
      body: const Center(
        child: Text('App agente de tránsito de RD'),
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
            )
          ],
        ),
      ),
    );
  }
}