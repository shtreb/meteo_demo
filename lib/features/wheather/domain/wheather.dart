class Weather {
  final double latitude;
  final double longitude;
  final String timezone;
  final double elevation;
  final CurrentWeatherData current;
  final List<HourlyWeatherData> hourly;

  Weather({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.elevation,
    required this.current,
    required this.hourly,
  });
}

class CurrentWeatherData {
  final String time;
  final double temperature;
  final num? humidity;
  final int weatherCode;

  CurrentWeatherData({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.weatherCode,
  });

  String getWeatherDescription() {
    // WMO Weather interpretation codes (WW)
    // https://open-meteo.com/en/docs
    if (weatherCode == 0) return 'Ясно';
    if (weatherCode == 1 || weatherCode == 2 || weatherCode == 3) return 'Облачно';
    if (weatherCode >= 45 && weatherCode <= 49) return 'Туман';
    if (weatherCode >= 51 && weatherCode <= 57) return 'Морось';
    if (weatherCode >= 61 && weatherCode <= 67) return 'Дождь';
    if (weatherCode >= 71 && weatherCode <= 77) return 'Снег';
    if (weatherCode >= 80 && weatherCode <= 82) return 'Ливень';
    if (weatherCode >= 85 && weatherCode <= 86) return 'Снегопад';
    if (weatherCode >= 95 && weatherCode <= 99) return 'Гроза';
    return 'Неизвестно';
  }
}

class HourlyWeatherData {
  final String time;
  final double temperature;
  final int? humidity;
  final int weatherCode;

  HourlyWeatherData({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.weatherCode,
  });
}

