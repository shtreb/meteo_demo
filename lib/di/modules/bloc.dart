import 'package:injectable/injectable.dart';
import '../../features/wheather/data/wheather_repository.dart';
import '../../features/wheather/presentation/bloc/wheather_bloc.dart';
import '../../features/map/presentation/bloc/map_bloc.dart';
import '../../core/local/local_storage.dart';

@module
abstract class BlocModule {
  @injectable
  WeatherBloc weatherBloc(
    IWeatherRepository repository,
    LocalStorage localStorage,
  ) => WeatherBloc(repository, localStorage);

  @injectable
  MapBloc mapBloc(
    IWeatherRepository repository,
  ) => MapBloc(repository);
}

