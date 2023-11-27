abstract class CarroEvento {}

class Inicializado extends CarroEvento {}

class CarroSeleccionado extends CarroEvento {
  final int indiceSeleccionado;

  CarroSeleccionado({required this.indiceSeleccionado});
}

class GetCarros extends CarroEvento {}

class InsertarCarro extends CarroEvento {
  final String apodo;

  InsertarCarro({
    required this.apodo,
  });
}

class EliminarCarro extends CarroEvento {
  final int idCarro;

  EliminarCarro({required this.idCarro});
}
