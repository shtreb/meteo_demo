import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../wheather/domain/wheather.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.initial() = MapInitial;
  const factory MapState.loading() = MapLoading;
  const factory MapState.loaded(Weather weather) = MapLoaded;
  const factory MapState.error(String message) = MapError;
}

