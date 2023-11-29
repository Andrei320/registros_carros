import 'package:bloc/bloc.dart';
import 'package:registros_carros/bloc/movimientos_bloc/movimientos_bloc_estado.dart';
import 'package:registros_carros/bloc/movimientos_bloc/movimientos_bloc_eventos.dart';
import 'package:registros_carros/database_helper/carros_database_helper.dart';

class MovimientoBloc extends Bloc<MovimientoEvento, MovimientoEstado> {
  final DBCarro dbCarro;
  MovimientoBloc(this.dbCarro) : super(EstadoMovimientoInicial()) {
    on<MovimientoInicializado>((event, emit) {
      emit(EstadoMovimientoInicial());
    });

    on<MovimientoSeleccionado>((event, emit) {
      final int idSeleccionado = event.indiceSeleccionado;
      emit(MovimientoSeleccionadoEstado(idSeleccionado: idSeleccionado));
    });

    on<GetMovimientos>((event, emit) async {
      try {
        final movimientos = await dbCarro.getMovimientos();
        emit(GetAllMovimientos(movimientos: movimientos));
      } catch (e) {
        emit(ErrorGetAllMovimientos(
            mensajeError: 'Error al cargar todas las movimientos: $e'));
      }
    });

    on<InsertarMovimiento>((event, emit) async {
      try {
        await dbCarro.addMovimiento(
          event.nombremovimiento,
          event.idcarro,
          event.idcategoria,
          event.gastototal,
        );

        emit(MovimientoInsertado());
        add(GetMovimientos());
      } catch (e) {
        emit(ErrorAlInsertarMovimiento(
            mensajeError: 'Error al insertar el movimiento.'));
      }
    });

    on<EliminarMovimiento>((event, emit) {
      try {
        dbCarro.deleteMovimiento(event.idmovimiento);
        emit(MovimientoEliminado());
        add(GetMovimientos());
      } catch (e) {
        emit(ErrorAlEliminarMovimiento(
            mensajeError: 'Error al eliminar el movimiento.'));
      }
    });

    on<UpdateMovimiento>((event, emit) async {
      try {
        dbCarro.updateMovimiento(
          event.nombremovimiento,
          event.idcarro,
          event.idcategoria,
          event.gastototal,
          event.idmovimiento,
        );

        emit(MovimientoActualizado());
        add(GetMovimientos());
      } catch (e) {
        emit(ErrorAlActualizarMovimiento(
            mensajeError: 'Error al insertar el carro.'));
      }
    });
  }
}
