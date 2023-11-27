abstract class CarroEstado {
  get mensajeError => null;
}

class EstadoInicial extends CarroEstado {}

class CarroSeleccionadoEstado extends CarroEstado {
  final int idSeleccionado;

  CarroSeleccionadoEstado({required this.idSeleccionado});
}

class GetAllCarros extends CarroEstado {
  final List<Map<String, dynamic>> carros;

  GetAllCarros({required this.carros});
}

class CarroInsertado extends CarroEstado {}

class CarroEliminado extends CarroEstado {}

class ErrorAlInsertarCarro extends CarroEstado {
  @override
  final String mensajeError;

  ErrorAlInsertarCarro({required this.mensajeError});
}

class ErrorAlEliminarCarro extends CarroEstado {
  @override
  final String mensajeError;

  ErrorAlEliminarCarro({required this.mensajeError});
}

class ErrorGetAllCarros extends CarroEstado {
  @override
  final String mensajeError;

  ErrorGetAllCarros({required this.mensajeError});
}
