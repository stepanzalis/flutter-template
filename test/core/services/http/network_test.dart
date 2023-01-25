import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/io/services/api/network_info_checker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';

class MockDataConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUpAll(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection and return true',
      () async {
        // arrange
        final hasConnectionFuture = Future.value(true);

        when(() => mockDataConnectionChecker.hasConnection).thenAnswer((_) => hasConnectionFuture);

        // act
        final result = networkInfo.isConnected;
        // assert
        verify(() => mockDataConnectionChecker.hasConnection).called(1);
        expect(result, hasConnectionFuture);
      },
    );

    test(
      'should forward the call to DataConnectionChecker.hasConnection and return false',
      () async {
        // arrange
        final hasNotConnectionFuture = Future.value(false);

        when(() => mockDataConnectionChecker.hasConnection).thenAnswer((_) => hasNotConnectionFuture);
        // act
        final result = networkInfo.isConnected;
        // assert
        verify(() => mockDataConnectionChecker.hasConnection).called(1);
        expect(result, hasNotConnectionFuture);
      },
    );
  });
}
