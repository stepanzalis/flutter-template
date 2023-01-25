import 'package:template/common/extensions/extensions.dart';
import 'package:diacritic/diacritic.dart';
import 'package:intl/intl.dart';

extension StringExtensionX on String {
  String capitalize() {
    return isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  }

  String replaceWithDash() => replaceAll(' ', '_');
  bool get isBlank => trim().isEmpty;

  String normalize() => removeDiacritics(this);

  /// Return formatted time from give string
  String formatToTime([
    String format = DateFormatters.humanDateReadableFormat,
  ]) {
    try {
      final DateFormat formatter = DateFormat(format);
      return formatter.format(DateTime.parse(this).toLocal());
    } catch (e) {
      return "-";
    }
  }
}

extension StringExt on String? {
  String orEmpty() => this == null ? "" : this!;
  bool get isBlankOrNull => this?.isEmpty == true || this == null;
}
