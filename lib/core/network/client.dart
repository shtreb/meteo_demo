import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'response/weather_response.dart';

part 'client.g.dart';

@RestApi(baseUrl: 'https://api.open-meteo.com/v1')
abstract class WeatherClient {
  factory WeatherClient(Dio dio, {String baseUrl}) = _WeatherClient;

  @GET('/forecast')
  Future<WeatherResponse> getWeather(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('hourly') String hourly,
    @Query('current') String current,
    @Query('timezone') String? timezone,
  );
}

