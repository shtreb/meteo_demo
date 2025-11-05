import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import '../../../core/network/client.dart';
import '../../../core/network/response/weather_response.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/local/local_storage.dart';
import '../domain/wheather.dart';

abstract class IWeatherRepository {
  Future<Weather> getWeather();
  Future<Weather> getWeatherByCoordinates(double latitude, double longitude);
  Future<void> requestLocationPermission();
  Future<Position?> getCurrentPosition();
  Stream<ServiceStatus> getLocationServiceStatusStream();
  bool isLocationServiceEnabled();
}

class WeatherRepository implements IWeatherRepository {
  final WeatherClient _client;
  final LocalStorage _localStorage;

  WeatherRepository(this._client, this._localStorage);

  @override
  Future<Weather> getWeather() async {
    try {
      double? latitude;
      double? longitude;

      // Проверяем сохраненные координаты
      if (_localStorage.hasLocation()) {
        latitude = _localStorage.getLatitude();
        longitude = _localStorage.getLongitude();
      } else {
        // Получаем текущие координаты
        final position = await getCurrentPosition();
        if (position == null) {
          throw LocationException('Не удалось получить местоположение');
        }
        latitude = position.latitude;
        longitude = position.longitude;
        await _localStorage.saveLocation(latitude, longitude);
      }

      final response = await _client.getWeather(
        latitude!,
        longitude!,
        'temperature_2m,relative_humidity_2m,weathercode',
        'temperature_2m,relative_humidity_2m,weathercode',
        'auto',
      );

      return _mapResponseToWeather(response);
    } on DioException catch (e) {
      throw NetworkException(
        'Ошибка сети: ${e.message}',
        e.response?.statusCode,
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('Неизвестная ошибка: $e');
    }
  }

  @override
  Future<Weather> getWeatherByCoordinates(double latitude, double longitude) async {
    try {
      final response = await _client.getWeather(
        latitude,
        longitude,
        'temperature_2m,relativehumidity_2m,weathercode',
        'temperature_2m,relativehumidity_2m,weathercode',
        'auto',
      );

      // Сохраняем выбранные координаты
      await _localStorage.saveLocation(latitude, longitude);

      return _mapResponseToWeather(response);
    } on DioException catch (e) {
      throw NetworkException(
        'Ошибка сети: ${e.message}',
        e.response?.statusCode,
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException('Неизвестная ошибка: $e');
    }
  }

  Weather _mapResponseToWeather(WeatherResponse response) {
    final current = CurrentWeatherData(
      time: response.current.time,
      temperature: response.current.temperature2m,
      humidity: response.current.relativeHumidity2m ?? response.current.relativeHumidity2m2,
      weatherCode: response.current.weathercode,
    );

    final hourly = <HourlyWeatherData>[];
    for (var i = 0; i < response.hourly.time.length && i < 24; i++) {
      hourly.add(HourlyWeatherData(
        time: response.hourly.time[i],
        temperature: response.hourly.temperature2m[i],
        humidity: response.hourly.relativehumidity2m?[i],
        weatherCode: response.hourly.weathercode[i],
      ));
    }

    return Weather(
      latitude: response.latitude,
      longitude: response.longitude,
      timezone: response.timezone,
      elevation: response.elevation,
      current: current,
      hourly: hourly,
    );
  }

  @override
  Future<void> requestLocationPermission() async {
    final status = await permission.Permission.location.request();
    if (!status.isGranted) {
      throw PermissionException('Разрешение на геолокацию не предоставлено');
    }
  }

  @override
  Future<Position?> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException('Служба геолокации отключена');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw PermissionException('Разрешение на геолокацию отклонено');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw PermissionException(
        'Разрешение на геолокацию отклонено навсегда. Откройте настройки.',
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await _localStorage.saveLocation(position.latitude, position.longitude);
      return position;
    } catch (e) {
      throw LocationException('Не удалось получить местоположение: $e');
    }
  }

  @override
  Stream<ServiceStatus> getLocationServiceStatusStream() {
    return Geolocator.getServiceStatusStream();
  }

  @override
  bool isLocationServiceEnabled() {
    // Это синхронный метод не может проверить статус асинхронно
    // Будем использовать асинхронную проверку в bloc
    return false;
  }

  Future<bool> checkLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}

