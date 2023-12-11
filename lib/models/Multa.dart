// ignore_for_file: file_names

class Multa {
  String id;
  String cedula = '';
  String placa = '';
  String motivo = '';
  String evidencia = '';
  String comentario = '';
  late double latitud;
  late double longitud;
  late DateTime fecha;
 

  // Constructor que inicializa las propiedades obligatorias
  Multa({
    required this.id,
    required this.cedula,
    required this.placa,
    required this.motivo,
    required this.evidencia,
    required this.latitud,
    required this.longitud,
    required this.fecha,
    required this.comentario,
  });
}
