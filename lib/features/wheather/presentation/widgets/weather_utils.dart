part of '../wheather_page.dart';

LinearGradient getGradientForWeather(int weatherCode) {
  // Солнечно
  if (weatherCode == 0 || weatherCode == 1) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF4A90E2),
        const Color(0xFF5BA3F5),
        const Color(0xFF6BB6FF),
      ],
    );
  }
  // Облачно
  if (weatherCode >= 2 && weatherCode <= 3) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF6B7B8C),
        const Color(0xFF7A8A9B),
        const Color(0xFF8999AA),
      ],
    );
  }
  // Дождь
  if (weatherCode >= 61 && weatherCode <= 67 || weatherCode >= 80 && weatherCode <= 82) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF4A5568),
        const Color(0xFF5A6578),
        const Color(0xFF6A7588),
      ],
    );
  }
  // Снег
  if (weatherCode >= 71 && weatherCode <= 77 || weatherCode >= 85 && weatherCode <= 86) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF7B8A9A),
        const Color(0xFF8B9AAA),
        const Color(0xFF9BAABA),
      ],
    );
  }
  // Гроза
  if (weatherCode >= 95 && weatherCode <= 99) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF2D3748),
        const Color(0xFF3D4758),
        const Color(0xFF4D5768),
      ],
    );
  }
  // Туман
  if (weatherCode >= 45 && weatherCode <= 49) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF9CA3AF),
        const Color(0xFFACB3BF),
        const Color(0xFFBCC3CF),
      ],
    );
  }
  // По умолчанию
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.blue.shade400,
      Colors.blue.shade600,
      Colors.blue.shade800,
    ],
  );
}

String formatDateTime(DateTime dateTime) {
  final weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  final months = [
    'Января',
    'Февраля',
    'Марта',
    'Апреля',
    'Мая',
    'Июня',
    'Июля',
    'Августа',
    'Сентября',
    'Октября',
    'Ноября',
    'Декабря'
  ];
  
  return '${weekdays[dateTime.weekday - 1]}, ${dateTime.day} ${months[dateTime.month - 1]}';
}

String formatTime(DateTime dateTime) {
  final hour = dateTime.hour;
  if (hour == 0) return '00:00';
  if (hour < 10) return '0$hour:00';
  return '$hour:00';
}

IconData getWeatherIcon(int weatherCode) {
  if (weatherCode == 0) return Icons.wb_sunny;
  if (weatherCode == 1) return Icons.wb_twilight;
  if (weatherCode >= 2 && weatherCode <= 3) return Icons.cloud;
  if (weatherCode >= 45 && weatherCode <= 49) return Icons.foggy;
  if (weatherCode >= 51 && weatherCode <= 57) return Icons.grain;
  if (weatherCode >= 61 && weatherCode <= 67) return Icons.umbrella;
  if (weatherCode >= 71 && weatherCode <= 77) return Icons.ac_unit;
  if (weatherCode >= 80 && weatherCode <= 82) return Icons.beach_access;
  if (weatherCode >= 85 && weatherCode <= 86) return Icons.snowboarding;
  if (weatherCode >= 95 && weatherCode <= 99) return Icons.flash_on;
  return Icons.wb_cloudy;
}

