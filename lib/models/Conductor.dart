// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Conductor {
 String licencia ='';
 String foto ='';
 String nombre ='';
 String apellido ='';
 late DateTime nacimiento;
 String direccion ='';
 late int telefono;

 Conductor(
    {
      required this.licencia,
      required this.foto,
      required this.nombre,
      required this.apellido,
      required this.nacimiento,
      required this.direccion,
      required this.telefono
    }
  );

  Map<String, dynamic> toMap() {
    return {
      'licencia': licencia,
      'foto': foto,
      'nombre': nombre,
      'apellido': apellido,
      'nacimiento': Timestamp.fromDate(nacimiento), // Convertir DateTime a Timestamp para Firestore
      'direccion': direccion,
      'telefono': telefono,
    };
  }
}


