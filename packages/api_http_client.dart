import 'dart:convert';

import 'package:http/http.dart';
import 'package:session_provider/session_provider.dart';

/// {@template api_http_client}
/// HTTP API client.
/// {@endtemplate}
class ApiHttpClient {
  /// {@macro api_http_client}
  ApiHttpClient({
    required Client client,
    required SessionProvider sessionProvider,
  })  : _client = client,
        _sessionProvider = sessionProvider;

  final Client _client;
  final SessionProvider _sessionProvider;

  Future<Map<String, String>> _authenticatedHeaders([
    bool hasBody = true,
  ]) async {
    // const token =
    //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MzdlNDY3NWE5Y2ViOTAwMTY5ZTI3NzkiLCJyb2xlIjoiQWNjb3VudE93bmVyIiwic2Vzc2lvbktleSI6IjU5dWFaRnZAdzdkaFBaVTZEJEZxODN6WVNOSmhWM0R2IiwiaWF0IjoxNjc1MjgwNjk5LCJleHAiOjE2ODMwNTY2OTl9.e_dg6CajQdyNGE2smXg5IKekkUgIFVErrc7a3YBaxVc';
    final session = await _sessionProvider.fetchSession();
    assert(session.isValid);
    final token = session.authToken;
    final headers = {'Authorization': 'Bearer $token'};
    if (hasBody) {
      headers['Content-Type'] = 'application/json';
    }
    return headers;
  }

  Map<String, String> _unauthenticatedHeaders() {
    final headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    return headers;
  }

  /// Sends an HTTP GET request with the given [headers] to the given [uri].
  ///
  /// Throws [ClientException] if an error occurs.
  Future<Response> get(Uri uri, {Map<String, String>? headers}) async {
    try {
      return await _client.get(uri, headers: headers);
    } on ClientException {
      rethrow;
    }
  }

  /// Same as [get] but it applies authenticated headers.
  ///
  /// Throws [ClientException] if an error occurs.
  ///
  /// Throws [AssertionError] if token is null.
  Future<Response> authenticatedGet(Uri uri) async {
    try {
      final headers = await _authenticatedHeaders();
      return await get(uri, headers: headers);
    } on ClientException {
      rethrow;
    } on AssertionError {
      rethrow;
    }
  }

  /// Sends an HTTP POST request with the given [headers] and [body] to the
  /// given [uri].
  ///
  /// [encoding] defaults to [utf8].
  ///
  /// Throws [ClientException] if an error occurs.
  Future<Response> post(
    Uri uri, {
    Map<String, String>? headers,
    Encoding? encoding,
    required Map<String, dynamic> body,
  }) async {
    try {
      return await _client.post(
        uri,
        headers: headers ?? _unauthenticatedHeaders(),
        body: jsonEncode(body),
        encoding: encoding,
      );
    } on ClientException {
      rethrow;
    }
  }

  /// Same as [post] but it applies authenticated headers.
  ///
  /// Throws [ClientException] if an error occurs.
  ///
  /// Throws [AssertionError] if token is null.
  Future<Response> authenticatedPost(
    Uri uri, {
    Encoding? encoding,
    required Map<String, dynamic> body,
  }) async {
    try {
      final headers = await _authenticatedHeaders();
      return await post(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } on ClientException {
      rethrow;
    } on AssertionError {
      rethrow;
    }
  }

  /// Sends an HTTP PUT request with the given [headers] and [body] to the
  /// given [uri].
  ///
  /// [encoding] defaults to [utf8].
  ///
  /// Throws [ClientException] if an error occurs.
  Future<Response> put(
    Uri uri, {
    Map<String, String>? headers,
    Encoding? encoding,
    required Map<String, dynamic> body,
  }) async {
    try {
      return await _client.put(
        uri,
        headers: headers ?? _unauthenticatedHeaders(),
        body: jsonEncode(body),
        encoding: encoding,
      );
    } on ClientException {
      rethrow;
    }
  }

  /// Same as [put] but it applies authenticated headers.
  ///
  /// Throws [ClientException] if an error occurs.
  ///
  /// Throws [AssertionError] if token is null.
  Future<Response> authenticatedPut(
    Uri uri, {
    Encoding? encoding,
    required Map<String, dynamic> body,
  }) async {
    try {
      final headers = await _authenticatedHeaders();
      return await put(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } on ClientException {
      rethrow;
    } on AssertionError {
      rethrow;
    }
  }

  /// Sends an HTTP DELETE request with the given [headers] to the given [uri].
  ///
  /// Throws [ClientException] if an error occurs.
  Future<Response> delete(
    Uri uri, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Encoding? encoding,
  }) async {
    try {
      return await _client.delete(
        uri,
        headers: headers,
        body: jsonEncode(body),
        encoding: encoding,
      );
    } on ClientException {
      rethrow;
    }
  }

  /// Same as [delete] but it applies authenticated headers.
  ///
  /// Throws [ClientException] if an error occurs with the request.
  ///
  /// Throws [AssertionError] if token is null.
  Future<Response> authenticatedDelete(
    Uri uri, {
    Map<String, dynamic>? body,
    Encoding? encoding,
  }) async {
    try {
      final headers = await _authenticatedHeaders(body != null);
      return await delete(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } on ClientException {
      rethrow;
    } on AssertionError {
      rethrow;
    }
  }
}
