part of '../wheather_page.dart';

Widget buildMainWeatherCard(BuildContext context, weather) {
  final current = weather.current;
  final time = DateTime.parse(current.time);
  
  return Column(
    children: [
      // Иконка погоды
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Icon(
          getWeatherIcon(current.weatherCode),
          size: 80,
          color: Colors.white,
        ),
      ),
      
      const SizedBox(height: 32),
      
      // Температура
      Text(
        '${current.temperature.toStringAsFixed(0)}°',
        style: const TextStyle(
          fontSize: 96,
          fontWeight: FontWeight.w300,
          color: Colors.white,
          height: 1.0,
          letterSpacing: -8,
        ),
      ),
      
      const SizedBox(height: 16),
      
      // Описание погоды
      Text(
        current.getWeatherDescription(),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.white.withValues(alpha: 0.9),
          letterSpacing: 0.5,
        ),
      ),
      
      const SizedBox(height: 8),
      
      // Время и локация
      Text(
        formatDateTime(time),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white.withValues(alpha: 0.7),
        ),
      ),
    ],
  );
}

