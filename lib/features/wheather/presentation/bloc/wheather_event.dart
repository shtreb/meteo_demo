import 'package:freezed_annotation/freezed_annotation.dart';

part 'wheather_event.freezed.dart';

@freezed
class WeatherEvent with _$WeatherEvent {
  const factory WeatherEvent.loadWeather() = LoadWeather;
  const factory WeatherEvent.loadWeatherByCoordinates(double latitude, double longitude) = LoadWeatherByCoordinates;
  const factory WeatherEvent.requestLocationPermission() = RequestLocationPermission;
  const factory WeatherEvent.checkLocationService() = CheckLocationService;
  const factory WeatherEvent.locationServiceStatusChanged(bool enabled) = LocationServiceStatusChanged;
}

