//Carros
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

class UpdateCarro extends CarroEvento {
  final String apodo;
  final int idcarro;

  UpdateCarro({required this.apodo, required this.idcarro});
}

class ArchivarCarro extends CarroEvento {
  final int idcarro;

  ArchivarCarro({required this.idcarro});
}

//Categorias

class CategoriaInicializada extends CarroEvento {}

class CategoriaSeleccionada extends CarroEvento {
  final int indiceSeleccionado;

  CategoriaSeleccionada({required this.indiceSeleccionado});
}

class GetCategorias extends CarroEvento {}

class InsertarCategoria extends CarroEvento {
  final String nombrecategoria;

  InsertarCategoria({
    required this.nombrecategoria,
  });
}

class EliminarCategoria extends CarroEvento {
  final int idcategoria;

  EliminarCategoria({required this.idcategoria});
}

class UpdateCategoria extends CarroEvento {
  final String nombrecategoria;
  final int idcategoria;

  UpdateCategoria({required this.nombrecategoria, required this.idcategoria});
}

class ArchivarCategoria extends CarroEvento {
  final int idcategoria;

  ArchivarCategoria({required this.idcategoria});
}
