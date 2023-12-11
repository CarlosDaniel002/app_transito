// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Horoscopo extends StatefulWidget {
  const Horoscopo({super.key});

  @override
  State<Horoscopo> createState() => _HoroscopoState();
}

class _HoroscopoState extends State<Horoscopo> {
  final Map<String, Map<String, dynamic>> h = {
    "1": {
      "Signo": "Aries",
      "Fechas": "21 de marzo - 19 de abril",
      "Características": ["Energético", "Impulsivo"],
      "Consejo": "Sé directo y comparte su entusiasmo por nuevos proyectos."
    },
    "2": {
      "Signo": "Tauro",
      "Fechas": "20 de abril - 20 de mayo",
      "Características": ["Paciente", "Terco"],
      "Consejo": "Sé claro en tus expectativas y da espacio para que tomen decisiones."
    },
    "3": {
      "Signo": "Géminis",
      "Fechas": "21 de mayo - 20 de junio",
      "Características": ["Versátil", "Sociable"],
      "Consejo": "Estimula su mente con conversaciones interesantes y mantén la diversidad."
    },
    "4": {
      "Signo": "Cáncer",
      "Fechas": "21 de junio - 22 de julio",
      "Características": ["Cariñoso", "Emocional"],
      "Consejo": "Comparte tus sentimientos y muestra comprensión."
    },
    "5": {
      "Signo": "Leo",
      "Fechas": "23 de julio - 22 de agosto",
      "Características": ["Carismático", "Orgulloso"],
      "Consejo": "Reconoce sus logros y elogia su creatividad."
    },
    "6": {
      "Signo": "Virgo",
      "Fechas": "23 de agosto - 22 de septiembre",
      "Características": ["Analítico", "Perfeccionista"],
      "Consejo": "Sé organizado y aprecia su atención a los detalles."
    },
    "7": {
      "Signo": "Libra",
      "Fechas": "23 de septiembre - 22 de octubre",
      "Características": ["Diplomático", "Indeciso"],
      "Consejo": "Sé paciente y ayuda a equilibrar sus decisiones."
    },
    "8": {
      "Signo": "Escorpio",
      "Fechas": "23 de octubre - 21 de noviembre",
      "Características": ["Intenso", "Reservado"],
      "Consejo": "Respeta su privacidad y sé honesto en la comunicación."
    },
    "9": {
      "Signo": "Sagitario",
      "Fechas": "22 de noviembre - 21 de diciembre",
      "Características": ["Aventurero", "Optimista"],
      "Consejo": "Anima sus sueños y comparte su entusiasmo por la vida."
    },
    "10": {
      "Signo": "Capricornio",
      "Fechas": "22 de diciembre - 19 de enero",
      "Características": ["Ambicioso", "Reservado"],
      "Consejo": "Valora su dedicación al trabajo y ofrece apoyo en sus metas."
    },
    "11": {
      "Signo": "Acuario",
      "Fechas": "20 de enero - 18 de febrero",
      "Características": ["Innovador", "Independiente"],
      "Consejo": "Aprecia su originalidad y da espacio para la independencia."
    },
    "12": {
      "Signo": "Piscis",
      "Fechas": "19 de febrero - 20 de marzo",
      "Características": ["Compasivo", "Soñador"],
      "Consejo": "Sé amable y comprensivo, comparte su amor por la creatividad."
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Horóscopo')),
        body: ListView.builder(
          itemCount: h.length,
          itemBuilder: (context, index) {
            final signo = h[(index + 1).toString()];
            if (signo != null) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Signo: ${signo['Signo']}'),
                    Text('Fechas: ${signo['Fechas']}'),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Características: ${signo['Características'].join(', ')}'),
                    Text('Consejo: ${signo['Consejo']}'),
                  ],
                ),
              );
            } else {
              return Container(); // O cualquier otro widget que desees mostrar en caso de índice inexistente
            }
          },
        ),
    );
  }
}