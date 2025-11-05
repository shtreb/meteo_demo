import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/local/local_storage.dart';
import '../../features/wheather/data/wheather_repository.dart';
import '../../core/network/client.dart';

@module
abstract class RepositoryModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  LocalStorage localStorage(SharedPreferences prefs) => LocalStorage(prefs);

  @lazySingleton
  IWeatherRepository weatherRepository(
    WeatherClient client,
    LocalStorage localStorage,
  ) => WeatherRepository(client, localStorage);
}

