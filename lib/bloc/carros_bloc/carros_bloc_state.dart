import '../../modelos_datos/carros_model.dart';

abstract class CarroState {}

class CarroInitialState extends CarroState {}

class CarroLoadingState extends CarroState {}

class CarroLoadedState extends CarroState {
  final List<Carro> carros;

  CarroLoadedState(this.carros);
}
