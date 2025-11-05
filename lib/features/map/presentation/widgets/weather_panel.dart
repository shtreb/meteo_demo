part of '../map_page.dart';

class WeatherPanel extends StatelessWidget {
  final Weather weather;
  final PanelController panelController;

  const WeatherPanel({
    super.key,
    required this.weather,
    required this.panelController,
  });

  @override
  Widget build(BuildContext context) {
    final current = weather.current;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Индикатор для перетаскивания
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Температура
                  Text(
                    '${current.temperature.toStringAsFixed(1)}°C',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.wb_sunny, size: 24, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        current.getWeatherDescription(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.water_drop, size: 24, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text('Влажность: ${current.humidity ?? 'N/A'}%', style: const TextStyle(fontSize: 16)),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

