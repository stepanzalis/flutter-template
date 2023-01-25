import 'package:mocktail/mocktail.dart';
import 'package:template/io/services/local/storage/storage_service.dart';
import 'package:template/io/services/api/http/http.dart';

class MockStorageService extends Mock implements StorageService {}

class MockHttpService extends Mock implements HttpService {}
