//Carros
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

class CarroActualizado extends CarroEstado {}

class CarroArchivado extends CarroEstado {}

class ErrorGetAllCarros extends CarroEstado {
  @override
  final String mensajeError;

  ErrorGetAllCarros({required this.mensajeError});
}

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

class ErrorAlActualizarCarro extends CarroEstado {
  @override
  final String mensajeError;

  ErrorAlActualizarCarro({required this.mensajeError});
}

class ErrorAlArchivarCarro extends CarroEstado {
  @override
  final String mensajeError;

  ErrorAlArchivarCarro({required this.mensajeError});
}

//Categorias

class CategoriaSeleccionadoEstado extends CarroEstado {
  final int idSeleccionado;

  CategoriaSeleccionadoEstado({required this.idSeleccionado});
}

class GetAllCategorias extends CarroEstado {
  final List<Map<String, dynamic>> categorias;

  GetAllCategorias({required this.categorias});
}

class CategoriaInsertada extends CarroEstado {}

class CategoriaActualizada extends CarroEstado {}

class CategoriaArchivada extends CarroEstado {}

class ErrorGetAllCategorias extends CarroEstado {
  @override
  final String mensajeError;

  ErrorGetAllCategorias({required this.mensajeError});
}

class ErrorAlInsertarCategoria extends CarroEstado {
  @override
  final String mensajeError;

  ErrorAlInsertarCategoria({required this.mensajeError});
}

class ErrorAlActualizarCategoria extends CarroEstado {
  @override
  final String mensajeError;

  ErrorAlActualizarCategoria({required this.mensajeError});
}

class ErrorAlArchivarCategoria extends CarroEstado {
  @override
  final String mensajeError;

  ErrorAlArchivarCategoria({required this.mensajeError});
}
