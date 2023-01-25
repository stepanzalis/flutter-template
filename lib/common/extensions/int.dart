/// Makes a range from given int to max number [maxInclusive]
extension RangeExtension on int {
  List<int> rangeTo(int maxInclusive, {int stepSize = 1}) => [
        for (int i = this; i <= maxInclusive; i += stepSize) i,
      ];
}
