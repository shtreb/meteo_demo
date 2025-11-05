import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/wheather.dart';

part 'wheather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = WeatherInitial;
  const factory WeatherState.loading() = WeatherLoading;
  const factory WeatherState.loaded(Weather weather, {bool? isLocationStale}) = WeatherLoaded;
  const factory WeatherState.error(String message) = WeatherError;
  const factory WeatherState.permissionDenied() = WeatherPermissionDenied;
  const factory WeatherState.locationServiceDisabled() = WeatherLocationServiceDisabled;
}

