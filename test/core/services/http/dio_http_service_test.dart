import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/io/services/local/storage/storage_service.dart';
import 'package:template/io/services/api/http/http.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import '../../../test_utils/mocks.dart';
import 'package:template/common/error/exceptions.dart';

void main() {
  late DioHttpService dioHttpService;
  late DioAdapter dioAdapter;
  late String apiUrl;

  StorageService storageService = MockStorageService();

  setUp(() {
    apiUrl = 'https://api.test/';

    dioAdapter = DioAdapter(
      dio: Dio(
        BaseOptions(
          baseUrl: apiUrl,
          // To handle errors manually rather than by Dio
          validateStatus: (status) => true,
          headers: {'accept': 'application/json', 'content-type': 'application/json'},
        ),
      ),
    );

    dioHttpService = DioHttpService(
      storageService,
      apiUrl,
      dioOverride: dioAdapter.dio,
      enableCaching: false,
    );
  });

  test(
    'HTTP service contains right API base URL',
    () {
      final baseUrl = 'https://api.test/';
      expect(baseUrl, apiUrl);
    },
  );

  test(
    'Dio contains JSON headers',
    () {
      final headers = dioAdapter.dio.options.headers;
      expect(
        headers,
        {'accept': 'application/json', 'content-type': 'application/json'},
      );
    },
  );

  test('Successful Get Request', () async {
    dioAdapter.onGet(
      'successful-get-request-test',
      (server) => server.reply(200, {'data': 'Success!'}),
    );

    final response = await dioHttpService.get(
      'successful-get-request-test',
    );

    expect(response, {'data': 'Success!'});
  });

  test('404 Get Request', () async {
    dioAdapter.onGet(
      '404-get-request-test',
      (server) => server.reply(404, {'error': '404 Error!'}),
    );

    expect(() async => await dioHttpService.get('404-get-request-test'), throwsA(isA<HttpException>()));

    try {
      await dioHttpService.get('404-get-request-test');
    } on HttpException catch (e) {
      expect(e.title, 'Http Error!');
      expect(e.statusCode, 404);
    }
  });

  test('Successful Post Request', () async {
    dioAdapter.onPost(
      'successful-post-request-test',
      (server) => server.reply(200, {'data': 'Success!'}),
    );

    final response = await dioHttpService.post(
      'successful-post-request-test',
    );

    expect(response, {'data': 'Success!'});
  });

  test('404 Post Request', () async {
    dioAdapter.onPost(
      '404-post-request-test',
      (server) => server.reply(404, {'error': '404 Error!'}),
    );

    expect(
      () async => await dioHttpService.post('404-post-request-test'),
      throwsA(isA<HttpException>()),
    );

    try {
      await dioHttpService.post('404-post-request-test');
    } on HttpException catch (e) {
      expect(e.title, 'Http Error!');
      expect(e.statusCode, 404);
    }
  });

  test('Successful Patch Request', () async {
    dioAdapter.onPatch(
      'successful-patch-request-test',
      (server) => server.reply(200, {'data': 'Patched!'}),
    );

    final response = await dioHttpService.patch(
      'successful-patch-request-test',
    );

    expect(response, {'data': 'Patched!'});
  });

  test('404 Patch Request', () async {
    dioAdapter.onPatch(
      '404-patch-request-test',
      (server) => server.reply(404, {'error': '404 Error!'}),
    );

    expect(
      () async => await dioHttpService.patch('404-patch-request-test'),
      throwsA(isA<HttpException>()),
    );

    try {
      await dioHttpService.patch('404-patch-request-test');
    } on HttpException catch (e) {
      expect(e.title, 'Http Error!');
      expect(e.statusCode, 404);
    }
  });

  test('Successful Put Request', () async {
    dioAdapter.onPatch(
      'successful-put-request-test',
      (server) => server.reply(200, {'data': 'Put!'}),
    );

    final response = await dioHttpService.patch(
      'successful-put-request-test',
    );

    expect(response, {'data': 'Put!'});
  });

  test('404 Put Request', () async {
    dioAdapter.onPatch(
      '404-put-request-test',
      (server) => server.reply(404, {'error': '404 Error!'}),
    );

    expect(
      () async => await dioHttpService.patch('404-put-request-test'),
      throwsA(isA<HttpException>()),
    );

    try {
      await dioHttpService.patch('404-put-request-test');
    } on HttpException catch (e) {
      expect(e.title, 'Http Error!');
      expect(e.statusCode, 404);
    }
  });
}
