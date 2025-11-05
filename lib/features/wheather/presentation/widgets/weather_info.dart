part of '../wheather_page.dart';

Widget buildWeatherInfo(BuildContext context, weather) {
  final current = weather.current;
  
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.2),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildInfoItem(
          Icons.water_drop,
          'Влажность',
          '${current.humidity}%',
        ),
        Container(
          width: 1,
          height: 40,
          color: Colors.white.withValues(alpha: 0.3),
        ),
        buildInfoItem(
          Icons.thermostat,
          'Ощущается',
          '${current.temperature.toStringAsFixed(0)}°',
        ),
      ],
    ),
  );
}

Widget buildInfoItem(IconData icon, String label, String value) {
  return Column(
    children: [
      Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white.withValues(alpha: 0.7),
        ),
      ),
    ],
  );
}

