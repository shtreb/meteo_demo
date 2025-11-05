class WeatherRequest {
  final double latitude;
  final double longitude;
  final String hourly;
  final String current;
  final String timezone;

  WeatherRequest({
    required this.latitude,
    required this.longitude,
    this.hourly = 'temperature_2m,relativehumidity_2m,weathercode',
    this.current = 'temperature_2m,relativehumidity_2m,weathercode',
    this.timezone = 'auto',
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'hourly': hourly,
      'current': current,
      'timezone': timezone,
    };
  }
}

