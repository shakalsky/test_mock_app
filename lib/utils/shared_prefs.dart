import 'package:shared_preferences/shared_preferences.dart';

class PreferencesDataSource {
  static const _urlPref = 'url';

  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  Future<String?> getUrl() {
    return _prefs.then((prefs) => prefs.getString(_urlPref));
  }

  Future<void> saveUrl(String url) {
    return _prefs.then((prefs) => prefs.setString(_urlPref, url));
  }
}
