import 'package:flutter/foundation.dart';

class Logger {
  static void d(String message, [String? tag]) {
    if (kDebugMode) {
      debugPrint('[${tag ?? 'DEBUG'}] $message');
    }
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

  static void i(String message, [String? tag]) {
    if (kDebugMode) {
      debugPrint('[${tag ?? 'INFO'}] $message');
    }
  }
}

