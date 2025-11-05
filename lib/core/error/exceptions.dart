class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(super.message, [super.statusCode]);
}

class LocationException extends AppException {
  LocationException(super.message);
}

class PermissionException extends AppException {
  PermissionException(super.message);
}

