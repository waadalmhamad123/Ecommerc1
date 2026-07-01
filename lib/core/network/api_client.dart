import 'dart:convert';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:http/http.dart' as http;
import '../../services/token_storage.dart';

class ApiClient {
  static const Duration _probeTimeout = Duration(seconds: 4);

  final String authToken;

  ApiClient({String? authToken})
      : authToken = authToken ?? TokenStorage.defaultAuthToken;

  Map<String, String> _buildHeaders({
    bool includeAuth = false,
    Map<String, String>? extra,
  }) {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    if (includeAuth && authToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
      headers['token'] = authToken;
    }
    if (extra != null) {
      headers.addAll(extra);
    }
    return headers;
  }

  Future<http.Response?> _tryGet(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    try {
      return await http.get(uri, headers: headers).timeout(_probeTimeout);
    } catch (_) {
      return null;
    }
  }

  Future<http.Response?> _trySend(Future<http.Response> Function() send) async {
    try {
      return await send().timeout(_probeTimeout);
    } catch (_) {
      return null;
    }
  }

  List<String> _candidateHosts() {
    if (kIsWeb) return ['localhost:5000'];
    if (defaultTargetPlatform == TargetPlatform.android) {
      return ['127.0.0.1:5000', 'localhost:5000', '10.0.2.2:5000'];
    }
    return ['localhost:5000'];
  }

  Uri _buildUri(
    String host,
    String path, {
    Map<String, String>? queryParameters,
  }) {
    final qs = queryParameters ?? {};
    return Uri.http(host, path, qs);
  }

  Future<http.Response?> get(
    String path, {
    Map<String, String>? queryParameters,
    bool includeAuth = false,
  }) async {
    for (final host in _candidateHosts()) {
      try {
        final uri = _buildUri(host, path, queryParameters: queryParameters);
        final headers = _buildHeaders(includeAuth: includeAuth);
        final res = await _tryGet(uri, headers: headers);
        if (res != null) return res;
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  Future<http.Response?> post(
    String path, {
    Map<String, String>? queryParameters,
    bool includeAuth = false,
    Object? body,
  }) async {
    for (final host in _candidateHosts()) {
      try {
        final uri = _buildUri(host, path, queryParameters: queryParameters);
        final headers = _buildHeaders(includeAuth: includeAuth);
        final res = await _trySend(
          () => http.post(uri, headers: headers, body: body),
        );
        if (res != null) return res;
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  Future<http.Response?> put(
    String path, {
    Map<String, String>? queryParameters,
    bool includeAuth = false,
    Object? body,
  }) async {
    for (final host in _candidateHosts()) {
      try {
        final uri = _buildUri(host, path, queryParameters: queryParameters);
        final headers = _buildHeaders(includeAuth: includeAuth);
        final res = await _trySend(
          () => http.put(uri, headers: headers, body: body),
        );
        if (res != null) return res;
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  Future<http.Response?> delete(
    String path, {
    Map<String, String>? queryParameters,
    bool includeAuth = false,
  }) async {
    for (final host in _candidateHosts()) {
      try {
        final uri = _buildUri(host, path, queryParameters: queryParameters);
        final headers = _buildHeaders(includeAuth: includeAuth);
        final res = await _trySend(() => http.delete(uri, headers: headers));
        if (res != null) return res;
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  static dynamic decodeBody(String body) {
    return json.decode(body);
  }
}
