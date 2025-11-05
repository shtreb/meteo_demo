import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _latitudeKey = 'latitude';
  static const String _longitudeKey = 'longitude';
  static const String _lastUpdateKey = 'last_location_update';

  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  Future<void> saveLocation(double latitude, double longitude) async {
    await _prefs.setDouble(_latitudeKey, latitude);
    await _prefs.setDouble(_longitudeKey, longitude);
    await _prefs.setInt(_lastUpdateKey, DateTime.now().millisecondsSinceEpoch);
  }

  double? getLatitude() => _prefs.getDouble(_latitudeKey);
  double? getLongitude() => _prefs.getDouble(_longitudeKey);
  int? getLastUpdateTimestamp() => _prefs.getInt(_lastUpdateKey);

  bool hasLocation() {
    return getLatitude() != null && getLongitude() != null;
  }

  DateTime? getLastUpdateTime() {
    final timestamp = getLastUpdateTimestamp();
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  bool isLocationStale() {
    final lastUpdate = getLastUpdateTime();
    if (lastUpdate == null) return true;
    final difference = DateTime.now().difference(lastUpdate);
    return difference.inHours >= 2;
  }

  Future<void> clearLocation() async {
    await _prefs.remove(_latitudeKey);
    await _prefs.remove(_longitudeKey);
    await _prefs.remove(_lastUpdateKey);
  }
}

