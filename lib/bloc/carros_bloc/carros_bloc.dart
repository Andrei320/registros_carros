import 'package:bloc/bloc.dart';
import 'package:registros_carros/bloc/carros_bloc/carros_bloc_event.dart';
import 'package:registros_carros/bloc/carros_bloc/carros_bloc_state.dart';
import 'package:registros_carros/modelos_datos/carros_model.dart';
import 'package:registros_carros/database_helper/carros_database_helper.dart';

class CarroBloc extends Bloc<CarroEvent, CarroState> {
  CarroBloc() : super(CarroLoadedState([]));
}
