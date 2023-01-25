abstract class StorageService {
  Future<void> init();

  Future<void> remove(String key);

  T get<T>(String key);

  List<T> getAll<T>();

  Future<void> clear();

  bool has(String key);

  Future<void> set(String key, dynamic data);

  Future<void> close();
}
