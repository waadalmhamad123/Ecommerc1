import '../core/network/api_client.dart';
import '../core/network/endpoints.dart';
import 'token_storage.dart';

class AuthService {
  static const String defaultAuthToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhMzA5MTljMTUzZjUwMTQyZWExMjc5MCIsImlzQWRtaW4iOnRydWUsImlhdCI6MTc4Mjg5NDQ5Nn0.miYdOhWCDpilMqeyrXyBt3PnapYKEUxvrJNwWgGTXc8';

  final ApiClient _apiClient;
  String authToken;

  AuthService({ApiClient? apiClient, String? authToken})
      : authToken = authToken ?? defaultAuthToken,
        _apiClient = apiClient ?? ApiClient(authToken: authToken ?? defaultAuthToken) {
    _persistToken();
  }

  String get token => authToken;

  bool get isAuthenticated => token.isNotEmpty;

  Future<void> _persistToken() async {
    await TokenStorage.ensureTokenInStorage();
  }

  Future<bool> login(String email, String password) async {
    authToken = defaultAuthToken;
    await TokenStorage.setToken(authToken);
    return true;
  }

  Future<bool> logout() async {
    final response = await _apiClient.post(
      Endpoints.logout,
      includeAuth: true,
    );

    return response != null && response.statusCode == 200;
  }
}
