import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo_demo/core/error/exceptions.dart';
import 'package:meteo_demo/core/local/local_storage.dart';
import 'package:meteo_demo/features/wheather/data/wheather_repository.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'wheather_event.dart';
import 'wheather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final IWeatherRepository _repository;
  final LocalStorage _localStorage;

  WeatherBloc(this._repository, this._localStorage) : super(const WeatherInitial()) {
    on<LoadWeather>(_onLoadWeather);
    on<LoadWeatherByCoordinates>(_onLoadWeatherByCoordinates);
    on<RequestLocationPermission>(_onRequestLocationPermission);
    on<CheckLocationService>(_onCheckLocationService);
    on<LocationServiceStatusChanged>(_onLocationServiceStatusChanged);

    // Подписываемся на изменения состояния геолокационного сервиса
    _repository.getLocationServiceStatusStream().listen((status) {
      add(LocationServiceStatusChanged(status == ServiceStatus.enabled));
    });
  }

  Future<void> _onLoadWeather(
    LoadWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());

    try {
      // Проверяем наличие сохраненных координат
      if (_localStorage.hasLocation()) {
        final isStale = _localStorage.isLocationStale();
        try {
          final weather = await _repository.getWeather();
          emit(WeatherLoaded(weather, isLocationStale: isStale));
          return;
        } catch (e) {
          // Если ошибка при получении погоды, продолжаем проверку сервиса
        }
      }

      // Проверяем разрешения
      final permission = await permission_handler.Permission.location.status;
      if (!permission.isGranted) {
        emit(const WeatherPermissionDenied());
        return;
      }

      // Проверяем включен ли сервис геолокации
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(const WeatherLocationServiceDisabled());
        return;
      }

      // Получаем погоду
      final weather = await _repository.getWeather();
      final isStale = _localStorage.isLocationStale();
      emit(WeatherLoaded(weather, isLocationStale: isStale));
    } on PermissionException catch (e) {
      emit(WeatherError(e.message));
    } on LocationException catch (e) {
      emit(WeatherError(e.message));
    } on NetworkException catch (e) {
      emit(WeatherError(e.message));
    } on AppException catch (e) {
      emit(WeatherError(e.message));
    } catch (e) {
      emit(WeatherError('Произошла неизвестная ошибка: $e'));
    }
  }

  Future<void> _onLoadWeatherByCoordinates(
    LoadWeatherByCoordinates event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());

    try {
      final weather = await _repository.getWeatherByCoordinates(
        event.latitude,
        event.longitude,
      );
      emit(WeatherLoaded(weather, isLocationStale: false));
    } on NetworkException catch (e) {
      emit(WeatherError(e.message));
    } on AppException catch (e) {
      emit(WeatherError(e.message));
    } catch (e) {
      emit(WeatherError('Произошла неизвестная ошибка: $e'));
    }
  }

  Future<void> _onRequestLocationPermission(
    RequestLocationPermission event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      await _repository.requestLocationPermission();
      // После получения разрешения проверяем сервис и загружаем погоду
      add(const CheckLocationService());
    } on PermissionException catch (e) {
      emit(WeatherError(e.message));
    } catch (e) {
      emit(WeatherError('Не удалось получить разрешение: $e'));
    }
  }

  Future<void> _onCheckLocationService(
    CheckLocationService event,
    Emitter<WeatherState> emit,
  ) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(const WeatherLocationServiceDisabled());
      return;
    }

    // Если сервис включен, загружаем погоду
    add(const LoadWeather());
  }

  void _onLocationServiceStatusChanged(
    LocationServiceStatusChanged event,
    Emitter<WeatherState> emit,
  ) {
    if (!event.enabled) {
      emit(const WeatherLocationServiceDisabled());
    } else {
      // Если сервис включен, загружаем погоду
      add(const LoadWeather());
    }
  }
}

