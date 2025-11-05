import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_demo/core/error/exceptions.dart';
import '../../../wheather/data/wheather_repository.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final IWeatherRepository _repository;

  MapBloc(this._repository) : super(const MapInitial()) {
    on<LoadWeatherByCoordinates>(_onLoadWeatherByCoordinates);
  }

  Future<void> _onLoadWeatherByCoordinates(
    LoadWeatherByCoordinates event,
    Emitter<MapState> emit,
  ) async {
    emit(const MapLoading());

    try {
      final weather = await _repository.getWeatherByCoordinates(
        event.latitude,
        event.longitude,
      );
      emit(MapLoaded(weather));
    } on NetworkException catch (e) {
      emit(MapError(e.message));
    } on AppException catch (e) {
      emit(MapError(e.message));
    } catch (e) {
      emit(MapError('Произошла неизвестная ошибка: $e'));
    }
  }
}

