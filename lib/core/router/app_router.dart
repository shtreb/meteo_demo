import 'package:auto_route/auto_route.dart';
import '../../features/map/presentation/map_page.dart';
import '../../features/wheather/presentation/wheather_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [AutoRoute(page: WeatherRoute.page, initial: true), AutoRoute(page: MapRoute.page)];
}
