import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_demo/core/router/app_router.dart';
import 'package:meteo_demo/di/injection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shimmer/shimmer.dart';
import 'bloc/wheather_bloc.dart';
import 'bloc/wheather_event.dart';
import 'bloc/wheather_state.dart';

part 'widgets/weather_utils.dart';
part 'widgets/loading_state_widget.dart';
part 'widgets/loaded_state_widget.dart';
part 'widgets/main_weather_card.dart';
part 'widgets/weather_info.dart';
part 'widgets/hourly_forecast.dart';
part 'widgets/error_state_widget.dart';
part 'widgets/permission_denied_widget.dart';
part 'widgets/location_service_disabled_widget.dart';

@RoutePage()
class WeatherPage extends StatelessWidget implements AutoRouteWrapper {

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherBloc>()..add(const LoadWeather()),
      child: this,
    );
  }

  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              context.router.push(const MapRoute());
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<WeatherBloc>().add(const LoadWeather());
            },
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => buildLoadingState(context),
            loaded: (weather, isLocationStale) => buildLoadedState(
              context,
              weather,
              isLocationStale ?? false,
            ),
            error: (message) => buildErrorState(context, message),
            permissionDenied: () => buildPermissionDeniedState(context),
            locationServiceDisabled: () => buildLocationServiceDisabledState(context),
          );
        },
      ),
    );
  }
}
