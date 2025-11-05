part of '../wheather_page.dart';

Widget buildHourlyForecast(BuildContext context, weather) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Прогноз на 24 часа',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.9)),
      ),
      const SizedBox(height: 16),
      Container(
        height: 140,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: weather.hourly.length,
          itemBuilder: (context, index) {
            final hourly = weather.hourly[index];
            final time = DateTime.parse(hourly.time);
            final isNow = index == 0;

            return Container(
              width: 70,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: isNow ? 0.25 : 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: isNow ? 0.4 : 0.2), width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatTime(time),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  Icon(getWeatherIcon(hourly.weatherCode), color: Colors.white, size: 28),
                  Text(
                    '${hourly.temperature.toStringAsFixed(0)}°',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
