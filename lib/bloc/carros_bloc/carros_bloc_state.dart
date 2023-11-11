import 'package:bloc/bloc.dart';
import 'package:registros_carros/modelos_datos/carros_model.dart';

class CarrosState {}

class CarrosLoading extends CarrosState {}

class CarrosLoaded extends CarrosState {
  final List<Carro> carros;

  CarrosLoaded(this.carros);
}

class CarrosError extends CarrosState {
  final String errorMessage;

  CarrosError(this.errorMessage);
}
