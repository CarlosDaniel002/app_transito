// ignore_for_file: file_names

class Multa {
  String cedula = '';
  String placa = '';
  String motivo = '';
  String evidencia = '';
  String comentario = '';
  String nota = '';
  late double latitud;
  late double longitud;
  late DateTime fecha;
  late DateTime hora;

  // Constructor que inicializa las propiedades obligatorias
  Multa({
    required this.cedula,
    required this.placa,
    required this.motivo,
    required this.evidencia,
    required this.latitud,
    required this.longitud,
    required this.fecha,
    required this.hora,
    required this.comentario,
    required this.nota
  });
}
