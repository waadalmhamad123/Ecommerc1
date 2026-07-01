import '../core/network/api_client.dart';
import '../core/network/endpoints.dart';

class FavoriteService {
  final ApiClient _apiClient;

  FavoriteService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<bool> addToFavourite(String productId) async {
    if (productId.isEmpty) return false;

    final response = await _apiClient.post(
      Endpoints.addToFavourite(productId),
      includeAuth: true,
    );
    if (response == null) return false;

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
