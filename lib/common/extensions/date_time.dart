import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

class DateFormatters {
  /// All api response [2022-06-10 12:30:10Z]
  static const String apiFormat = 'yyyy-MM-dd hh:mm:ssZ';

  /// Date format for people [06.10.2022]
  static const String humanDateReadableFormat = 'dd.MM.yyyy';

  /// Date format for people [06.10.2022 12:30]
  static const String humanDateTimeReadableFormat = 'dd.MM.yyyy hh:mm';
}

extension DateTimeExt on DateTime {
  /// Returns formatted time from given [DateTime]
  String formatToTime([
    String format = DateFormatters.humanDateReadableFormat,
  ]) {
    try {
      return DateFormat(format).format(this);
    } catch (e) {
      logError("Error while parsing data: $e");
      return "-";
    }
  }
}
