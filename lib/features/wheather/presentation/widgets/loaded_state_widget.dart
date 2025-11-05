part of '../wheather_page.dart';

Widget buildLoadedState(
  BuildContext context,
  weather,
  bool isLocationStale,
) {
  final current = weather.current;
  final gradient = getGradientForWeather(current.weatherCode);
  
  return Container(
    height: double.infinity,
    decoration: BoxDecoration(
      gradient: gradient,
    ),
    child: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (isLocationStale)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Данные обновлялись более 2х часов назад',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Главная карточка с температурой
              buildMainWeatherCard(context, weather),
              
              const SizedBox(height: 32),
              
              // Информация о погоде
              buildWeatherInfo(context, weather),
              
              const SizedBox(height: 24),
              
              // Прогноз на 24 часа
              buildHourlyForecast(context, weather),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

