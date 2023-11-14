import '../../modelos_datos/carros_model.dart';

abstract class CarroEvent {}

class FetchCarrosEvent extends CarroEvent {}

class AddCarroEvent extends CarroEvent {
  final Carro nuevoCarro;

  AddCarroEvent(this.nuevoCarro);
}

class DeleteCarroEvent extends CarroEvent {
  final Carro idCarro;

  DeleteCarroEvent(this.idCarro);
}

class UpdateCarroEvent extends CarroEvent {
  final Carro idCarro;

  UpdateCarroEvent(this.idCarro);
}
