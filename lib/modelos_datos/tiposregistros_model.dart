class TipoRegistros {
  int idtipo_registro;
  String nombre;

  TipoRegistros({
    required this.idtipo_registro,
    required this.nombre,
  });

  // Convierte el objeto a un mapa para almacenarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'idtipo_registro': idtipo_registro,
      'nombre': nombre,
    };
  }

  // Construye un objeto Carro a partir de un mapa almacenado en la base de datos
  factory TipoRegistros.fromMap(Map<String, dynamic> map) {
    return TipoRegistros(
      idtipo_registro: map['idtipo_registro'],
      nombre: map['nombre'],
    );
  }
}
