import 'package:template/common/extensions/extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Valid limit range numbers',
    () {
      test(
        'range contains start number',
        () {
          final range = 0.rangeTo(10);

          final containsNumber = range.contains(0);
          expect(true, containsNumber);
        },
      );

      test(
        'range contains end number',
        () {
          final range = 0.rangeTo(10);

          final containsNumber = range.contains(10);
          expect(true, containsNumber);
        },
      );
    },
  );

  group('All numbers in range are valid', () {
    test(
      '- range contains all numbers ',
      () {
        final range = 0.rangeTo(3);

        final first = range.contains(0);
        final second = range.contains(1);
        final third = range.contains(2);
        final four = range.contains(3);

        expect(true, first);
        expect(true, second);
        expect(true, third);
        expect(true, four);
      },
    );
  });
}
