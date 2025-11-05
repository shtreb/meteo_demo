import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../wheather/domain/wheather.dart';
import 'bloc/map_bloc.dart';
import 'bloc/map_event.dart';
import 'bloc/map_state.dart';
import '../../../di/injection.dart' show getIt;

part 'widgets/weather_panel.dart';

@RoutePage()
class MapPage extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => getIt<MapBloc>(), child: this);
  }

  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  final PanelController _panelController = PanelController();
  LatLng? _selectedLocation;
  LatLng? _currentLocation;
  Weather? _selectedLocationWeather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите местоположение'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (weather) {
              setState(() {
                _selectedLocationWeather = weather;
              });
              _panelController.open();
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
            },
          );
        },
        builder: (context, state) {
          return SlidingUpPanel(
            controller: _panelController,
            minHeight: 0,
            maxHeight: 260,
            panel:
                _selectedLocationWeather != null
                    ? WeatherPanel(weather: _selectedLocationWeather!, panelController: _panelController)
                    : const SizedBox.shrink(),
            body: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation ?? const LatLng(55.7558, 37.6173),
                initialZoom: 12.0,
                onTap: (tapPosition, point) {
                  setState(() {
                    _selectedLocation = point;
                    _selectedLocationWeather = null; // Сбрасываем погоду при новом выборе
                  });
                  _panelController.close();
                  // Загружаем погоду для выбранной точки
                  context.read<MapBloc>().add(LoadWeatherByCoordinates(point.latitude, point.longitude));
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'meteo_demo',
                ),
                MarkerLayer(
                  markers: [
                    if (_currentLocation != null)
                      Marker(
                        point: _currentLocation!,
                        width: 40,
                        height: 40,
                        child: Icon(Icons.my_location, color: Colors.blue, size: 32),
                      ),
                    if (_selectedLocation != null && _selectedLocation != _currentLocation)
                      Marker(
                        point: _selectedLocation!,
                        width: 40,
                        height: 40,
                        child: Icon(Icons.location_on, color: Colors.red, size: 40),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
