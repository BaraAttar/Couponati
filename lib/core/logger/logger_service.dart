import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error, fatal }

class AppLogger {
  static late Logger _logger;
  static bool _initialized = false;

  static void initialize({
    LogLevel logLevel = LogLevel.debug,
    bool enableFileLogging = false,
  }) {
    if (_initialized) return;

    _logger = Logger(
      level: _getLoggerLevel(logLevel),
      printer: kDebugMode 
          ? PrettyPrinter(
              methodCount: 2,
              errorMethodCount: 5,
              lineLength: 120,
              colors: true,
              printEmojis: false,
              printTime: true,
            )
          : SimplePrinter(colors: false), // للإنتاج
      filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
    );
    
    _initialized = true;
  }

  static Level _getLoggerLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return Level.debug;
      case LogLevel.info:
        return Level.info;
      case LogLevel.warning:
        return Level.warning;
      case LogLevel.error:
        return Level.error;
      case LogLevel.fatal:
        return Level.fatal;
    }
  }

  // Logging methods
  static void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void f(String message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  // Context-specific logging
  static void api(String endpoint, {String? method, int? statusCode, dynamic data}) {
    final prefix = statusCode != null 
        ? (statusCode >= 200 && statusCode < 300 ? '✅' : '❌')
        : '🌐';
    i('$prefix API ${method ?? 'CALL'}: $endpoint${statusCode != null ? ' ($statusCode)' : ''}', data);
  }

  static void ui(String event, [dynamic data]) {
    d('🎨 UI: $event', data);
  }

  static void business(String event, [dynamic data]) {
    i('💼 Business: $event', data);
  }

  static void _ensureInitialized() {
    if (!_initialized) {
      initialize(); // Initialize with defaults
    }
  }
}