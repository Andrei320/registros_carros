import 'package:bloc/bloc.dart';
import 'package:registros_carros/modelos_datos/carros_model.dart';

abstract class CarrosEvent {}

class FetchCarrosEvent extends CarrosEvent {}

class AddCarroEvent extends CarrosEvent {
  final Carro nuevoCarro;

  AddCarroEvent(this.nuevoCarro);
}

class UpdateCarroEvent extends CarrosEvent {
  final Carro carroActualizado;

  UpdateCarroEvent(this.carroActualizado);
}

class DeleteCarroEvent extends CarrosEvent {
  final Carro carroAEliminar;

  DeleteCarroEvent(this.carroAEliminar);
}
