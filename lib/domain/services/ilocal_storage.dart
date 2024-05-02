abstract interface class ILocalStorage {
  Future<dynamic> read({required String key});
  Future<void> save({required String key, required dynamic data});
  Future<void> delete({required String key});
  Future<void> deleteAll();
}
