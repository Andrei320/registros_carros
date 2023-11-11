class Registro {
  int idregistro;
  int idcarro;
  int id_tiporegistro;
  double cantidad_gastada;
  String fecha_registro;

  Registro({
    required this.idregistro,
    required this.idcarro,
    required this.id_tiporegistro,
    required this.cantidad_gastada,
    required this.fecha_registro,
  });

  // Convierte el objeto a un mapa para almacenarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'idregistro': idregistro,
      'idcarro': idcarro,
      'id_tiporegistro': id_tiporegistro,
      'cantidad_gastada': cantidad_gastada,
      'fecha_registro': fecha_registro,
    };
  }

  // Construye un objeto Registro a partir de un mapa almacenado en la base de datos
  factory Registro.fromMap(Map<String, dynamic> map) {
    return Registro(
      idregistro: map['idregistro'],
      idcarro: map['idcarro'],
      id_tiporegistro: map['id_tiporegistro'],
      cantidad_gastada: map['cantidad_gastada'],
      fecha_registro: map['fecha_registro'],
    );
  }
}
