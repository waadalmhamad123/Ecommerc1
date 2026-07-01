import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String authTokenKey = 'auth_token';
  static const String defaultAuthToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhMzA5MTljMTUzZjUwMTQyZWExMjc5MCIsImlzQWRtaW4iOnRydWUsImlhdCI6MTc4Mjg5NDQ5Nn0.miYdOhWCDpilMqeyrXyBt3PnapYKEUxvrJNwWgGTXc8';

  static Future<SharedPreferences> _prefs() async {
    return SharedPreferences.getInstance();
  }

  static Future<String> getToken() async {
    final prefs = await _prefs();
    return prefs.getString(authTokenKey) ?? defaultAuthToken;
  }

  static Future<void> ensureTokenInStorage() async {
    final prefs = await _prefs();
    if (!prefs.containsKey(authTokenKey)) {
      await prefs.setString(authTokenKey, defaultAuthToken);
    }
  }

  static Future<void> setToken(String token) async {
    final prefs = await _prefs();
    await prefs.setString(authTokenKey, token);
  }
}
