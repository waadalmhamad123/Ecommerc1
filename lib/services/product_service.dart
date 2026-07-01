import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import '../core/network/api_client.dart';
import '../core/network/endpoints.dart';
import '../models/product.dart';

class ProductService {
  final ApiClient _apiClient;

  ProductService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<List<Product>> fetchProducts({int page = 1, int limit = 1000}) async {
    final response = await _apiClient.get(
      Endpoints.products,
      includeAuth: true,
      queryParameters: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );

    if (response == null || response.statusCode != 200) {
      return [];
    }

    final body = ApiClient.decodeBody(response.body);
    final items = _extractItems(body);

    return items
        .map<Product>((e) => Product.fromMap(e as Map<String, dynamic>, _normalizeImagePath))
        .toList();
  }

  Future<List<Product>> filterProducts({
    String? category,
    String? name,
    int page = 1,
    int limit = 1000,
    int? minPrice,
    int? maxPrice,
  }) async {
    final queryParameters = <String, String>{
      if (category != null && category.isNotEmpty) 'category': category,
      if (name != null && name.isNotEmpty) 'name': name,
      if (minPrice != null) 'minPrice': minPrice.toString(),
      if (maxPrice != null) 'maxPrice': maxPrice.toString(),
      'page': page.toString(),
      'limit': limit.toString(),
    };

    final response = await _apiClient.get(
      Endpoints.filter,
      includeAuth: true,
      queryParameters: queryParameters,
    );

    if (response == null || response.statusCode != 200) {
      return [];
    }

    final body = ApiClient.decodeBody(response.body);
    final items = _extractItems(body);

    return items
        .map<Product>((e) => Product.fromMap(e as Map<String, dynamic>, _normalizeImagePath))
        .toList();
  }

  List<dynamic> _extractItems(dynamic body) {
    if (body is List) return body;
    if (body is Map) {
      if (body['data'] != null) return body['data'];
      if (body['products'] != null) return body['products'];
      if (body['result'] != null) return body['result'];
      if (body['docs'] != null) return body['docs'];
    }
    return [];
  }

  String _normalizeImagePath(dynamic raw) {
    if (raw == null) return 'assets/images/laptop.jpg';
    final s = raw.toString().trim();
    if (s.isEmpty) return 'assets/images/laptop.jpg';

    if (s.startsWith('http://') || s.startsWith('https://')) {
      return s.replaceAll('\\', '/');
    }

    var path = s.replaceAll('\\', '/');
    if (path.startsWith('assets/')) return path;
    if (path.startsWith('images/') || path.contains('/images/')) {
      return _apiHostForPath(path);
    }
    if (path.startsWith('uploads/') || path.startsWith('files/') || path.contains('/')) {
      return _apiHostForPath(path);
    }
    if (!path.contains('/')) return 'assets/images/$path';
    return 'assets/$path';
  }

  String _apiHostForPath(String path) {
    final host = _detectApiHost();
    final clean = path.startsWith('/') ? path.substring(1) : path;
    return 'http://$host/$clean';
  }

  String _detectApiHost() {
    if (kIsWeb) return 'localhost:5000';
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '10.0.2.2:5000';
    }
    return 'localhost:5000';
  }
}
