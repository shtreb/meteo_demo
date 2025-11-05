import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meteo_demo/core/utils/logger.dart';
import '../../core/network/client.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, logPrint: (object) => Logger.d(object.toString(), 'DIO')),
    );

    return dio;
  }

  @lazySingleton
  WeatherClient weatherClient(Dio dio) => WeatherClient(dio);
}
