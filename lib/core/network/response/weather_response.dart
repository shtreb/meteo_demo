import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;
  @JsonKey(name: 'generationtime_ms')
  final double generationtimeMs;
  @JsonKey(name: 'utc_offset_seconds')
  final int utcOffsetSeconds;
  @JsonKey(name: 'timezone')
  final String timezone;
  @JsonKey(name: 'timezone_abbreviation')
  final String timezoneAbbreviation;
  @JsonKey(name: 'elevation')
  final double elevation;
  @JsonKey(name: 'current')
  final CurrentWeather current;
  @JsonKey(name: 'hourly')
  final HourlyWeather hourly;

  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.current,
    required this.hourly,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class CurrentWeather {
  @JsonKey(name: 'time')
  final String time;
  @JsonKey(name: 'interval')
  final int? interval;
  @JsonKey(name: 'temperature_2m')
  final double temperature2m;
  @JsonKey(name: 'relative_humidity_2m')
  final int? relativeHumidity2m;
  @JsonKey(name: 'relativehumidity_2m')
  final int? relativeHumidity2m2;
  @JsonKey(name: 'weathercode')
  final int weathercode;

  CurrentWeather({
    required this.time,
    this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.relativeHumidity2m2,
    required this.weathercode,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}

@JsonSerializable()
class HourlyWeather {
  @JsonKey(name: 'time')
  final List<String> time;
  @JsonKey(name: 'temperature_2m')
  final List<double> temperature2m;
  @JsonKey(name: 'relativehumidity_2m')
  final List<int>? relativehumidity2m;
  @JsonKey(name: 'weathercode')
  final List<int> weathercode;

  HourlyWeather({
    required this.time,
    required this.temperature2m,
    required this.relativehumidity2m,
    required this.weathercode,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherToJson(this);
}

