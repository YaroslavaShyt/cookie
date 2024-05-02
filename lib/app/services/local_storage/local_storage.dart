import 'package:cookie/domain/services/ilocal_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements ILocalStorage {
  @override
  Future<void> delete({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Future<dynamic> read({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic data = prefs.getInt(key);
    return data;
  }

  @override
  Future<void> save({required String key, required dynamic data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, data);
  }
}
