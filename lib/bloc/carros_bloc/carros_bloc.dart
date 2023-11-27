import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:registros_carros/database_helper/carros_database_helper.dart';
import 'package:registros_carros/bloc/carros_bloc/carros_bloc_event.dart';
import 'package:registros_carros/bloc/carros_bloc/carros_bloc_state.dart';

class CarroBloc extends Bloc<CarroEvento, CarroEstado> {
  CarroBloc() : super(EstadoInicial()) {
    on<Inicializado>((event, emit) {
      // Lógica de inicialización si es necesario
    });

    on<CarroSeleccionado>((event, emit) {
      final int idSeleccionado = event.indiceSeleccionado;
      emit(CarroSeleccionadoEstado(idSeleccionado: idSeleccionado));
    });

    on<InsertarCarro>((event, emit) async {
      try {
        DBCarro.addCarro(
          event.apodo,
        );
        final carros = await DBCarro.getCarros();
        emit(GetAllCarros(carros: carros));
      } catch (e) {
        emit(ErrorAlInsertarCarro(mensajeError: 'Error al insertar el carro.'));
      }
    });

    on<EliminarCarro>((event, emit) async {
      try {
        DBCarro.deleteCarro(event.idCarro);
        final carros = await DBCarro.getCarros();
        emit(GetAllCarros(carros: carros));
      } catch (e) {
        emit(ErrorAlEliminarCarro(mensajeError: 'Error al eliminar el carro.'));
      }
    });

    on<GetCarros>((event, emit) async {
      try {
        final carros = await DBCarro.getCarros();
        emit(GetAllCarros(carros: carros));
      } catch (e) {
        emit(ErrorGetAllCarros(
            mensajeError: 'Error al cargar todos los carros: $e'));
      }
    });
  }
}
