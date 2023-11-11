class Carro {
  String numero_placa;
  String apodo;

  Carro({
    required this.numero_placa,
    required this.apodo,
  });

  // Convierte el objeto a un mapa para almacenarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'numero_placa': numero_placa,
      'apodo': apodo,
    };
  }

  // Construye un objeto Carro a partir de un mapa almacenado en la base de datos
  factory Carro.fromMap(Map<String, dynamic> map) {
    return Carro(
      numero_placa: map['numero_placa'],
      apodo: map['apodo'],
    );
  }
}
