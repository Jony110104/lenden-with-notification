import 'package:logger/logger.dart';

class Log {
  late Logger _logger;
  static const lineLength = 120;

  Log._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        // number of method calls to be displayed
        errorMethodCount: 8,
        // number of method calls if stacktrace is provided
        lineLength: lineLength,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.dateAndTime,
      ),
    );
  }

  static final Log _singleton = Log._internal();

  static void verbose(String message) => _singleton._logger.v(message);

  static void debug(String message) => _singleton._logger.d(message);

  static void info(String message) => _singleton._logger.i(message);

  static void error(String message, {StackTrace? stackTrace}) =>
      _singleton._logger.e(
        message,
        stackTrace: stackTrace,
      );

  static void warning(String message) => _singleton._logger.w(message);
}
