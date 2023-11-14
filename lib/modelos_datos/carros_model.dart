class Carro {
  int? idCarro;
  String apodo;

  Carro({
    this.idCarro,
    required this.apodo,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCarro': idCarro,
      'apodo': apodo,
    };
  }

  factory Carro.fromMap(Map<String, dynamic> map) {
    return Carro(
      idCarro: map['idCarro'],
      apodo: map['apodo'],
    );
  }
}
