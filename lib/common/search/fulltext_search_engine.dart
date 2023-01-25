import 'package:template/common/extensions/extensions.dart';

class FullTextSearchEngine {
  /// Search string based on multiple params in string which are delimeted by
  /// a space
  ///
  /// [query] String which is typically typed to search field
  ///
  /// [searchableString]
  /// For every class that supports search for multiple attributes, just
  /// create a field that holds searchable attributes
  static bool search({
    required String query,
    required String searchableString,
  }) {
    if (query.isEmpty) return true;

    final queryParts = query.split(" ");
    final preparedString = searchableString.normalize().toLowerCase();
    for (final part in queryParts) {
      if (!preparedString.contains(part.normalize().toLowerCase())) {
        return false;
      }
    }
    return true;
  }
}
