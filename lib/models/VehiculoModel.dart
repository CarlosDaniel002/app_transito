// ignore_for_file: file_names

class Vehiculo {
  String placa = '';
  String marca = '';
  String modelo = '';
  int anoFabricacion;
  String color = '';

  Vehiculo({
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.anoFabricacion,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'placa': placa,
      'marca': marca,
      'modelo': modelo,
      'añoFabricacion': anoFabricacion,
      'color': color,
    };
  }

  // Método para crear un objeto Vehiculo desde un mapa
  factory Vehiculo.fromMap(Map<String, dynamic> map) {
    return Vehiculo(
      placa: map['placa'],
      marca: map['marca'],
      modelo: map['modelo'],
      anoFabricacion: map['añoFabricacion'],
      color: map['color'],
    );
  }
}

