// ignore_for_file: file_names

import 'package:flutter/material.dart';
class TraficoDeMulta extends StatefulWidget {
  const TraficoDeMulta({super.key});

  @override
  State<TraficoDeMulta> createState() => _TraficoDeMultaState();
}

class _TraficoDeMultaState extends State<TraficoDeMulta> {
  final Map<String, Map<String, String>> multas = {
    "1": {
      "descripcion": "No cruzar por los puentes para peatones",
      "referencia": "Ley 241 art. 101- literal A",
      "precio": "RD\$1,000.00"
    },
    "2": {
      "descripcion": "Conducir un vehículo con exceso de pasajeros",
      "referencia": "Ley 241 art. 104",
      "precio": "RD\$1,000.00"
    },
    "3": {
      "descripcion": "Transportar más de dos pasajeros en el asiento delantero",
      "referencia": "Ley 241 art. 105-Literal A",
      "precio": "RD\$1,000.00"
    },
    "4": {
      "descripcion": "No tener marbete de revistas autorizadas",
      "referencia": "Ley 241 art. 110-Literal D",
      "precio": "RD\$1,000.00"
    },
    "5": {
      "descripcion":
          "Transportar bultos que impidan la fácil retrovisión al conductor",
      "referencia": "Ley 241 art. 120-Literal A",
      "precio": "RD\$1,000.00"
    },
    "6": {
      "descripcion": "Cristales Tintados",
      "referencia": "Ley 241 art. 120- literal A y 156",
      "precio": "RD\$1,000.00"
    },
    "7": {
      "descripcion":
          "No detener la marcha cuando un vehículo escolar está montando o desmontando pasajero",
      "referencia": "Ley 241 art. 122",
      "precio": "RD\$1,000.00"
    },
    "8": {
      "descripcion": "Tirar desperdicios en la vía publica",
      "referencia": "Ley 241 art. 130-Literal A",
      "precio": "RD\$1,000.00"
    },
    "9": {
      "descripcion":
          "Pararse en la calzada para ofrecer ventas de productos de cualquier clase",
      "referencia": "Ley 241 art. 130-Literal H",
      "precio": "RD\$1,000.00"
    },
    "10": {
      "descripcion":
          "Circular en oposición a las órdenes y señales del agente de tránsito",
      "referencia": "Ley 241art. 133-Literal B",
      "precio": "RD\$1,000.00"
    },
    "11": {
      "descripcion": "Transitar sin Tablilla",
      "referencia": "Ley 513-69",
      "precio": "RD\$1,000.00"
    },
    "12": {
      "descripcion": "Transitar con niños en asientos delanteros",
      "referencia": "Ley 241 art. 106",
      "precio": "RD\$1,667.00"
    },
    "13": {
      "descripcion": "Transitar sin cinturón",
      "referencia": "Ley 241 art. 6, Ley 114-99",
      "precio": "RD\$1,667.00"
    },
    "14": {
      "descripcion": "Conducir a exceso de velocidad",
      "referencia": "Ley 241 art. 61",
      "precio": "RD\$1,667.00"
    },
    "15": {
      "descripcion": "Manejo temerario",
      "referencia": "Ley 241 art. 65",
      "precio": "RD\$1,667.00"
    },
    "16": {
      "descripcion": "Conducir en estado de embriaguez",
      "referencia": "Ley 241 art. 93, art.131",
      "precio": "RD\$1,667.00"
    },
    "17": {
      "descripcion": "Violar la luz roja",
      "referencia": "Ley 241 art. 96 Literal B",
      "precio": "RD\$1,667.00"
    },
    "18": {
      "descripcion": "Hablando por celular",
      "referencia": "Ley 143, art. 1",
      "precio": "RD\$1,667.00"
    }
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarifario de Multas'),
      ),
      body: ListView.builder(
        itemCount: multas.length,
        itemBuilder: (context, index) {
          final multa = multas[(index + 1).toString()];
          if (multa != null) {
            return ListTile(
              title: Text(multa['descripcion']!),
              subtitle: Text('Referencia: ${multa['referencia']}'),
              trailing: Text('Precio: ${multa['precio']}'),
            );
          } else {
            return Container(); // O cualquier otro widget que desees mostrar en caso de índice inexistente
          }
        },
      ),
    );
  }
}
