import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';
import '../models/country.dart';

/// Exception thrown when an API request fails.
class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

/// HTTP client wrapper for the countries API.
class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches the list of countries from the API.
  ///
  /// Returns a list of [Country] objects.
  /// Throws [ApiException] on failure.
  Future<List<Country>> fetchCountries() async {
    try {
      final response = await _client
          .get(Uri.parse(ApiConstants.countriesUrl))
          .timeout(ApiConstants.timeoutDuration);

      if (response.statusCode != 200) {
        throw ApiException(
          'Failed to fetch countries: HTTP ${response.statusCode}',
        );
      }

      final Map<String, dynamic> body = json.decode(response.body);

      if (body['error'] == true) {
        throw ApiException(
          body['msg'] as String? ?? 'Unknown API error',
        );
      }

      final List<dynamic> data = body['data'] as List<dynamic>? ?? [];

      if (data.isEmpty) {
        throw ApiException('No countries returned from API');
      }

      return data
          .map((json) => Country.fromJson(json as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw const ApiException('No internet connection');
    } on FormatException {
      throw const ApiException('Invalid response format');
    } on http.ClientException catch (e) {
      throw ApiException('Network error: ${e.message}');
    }
  }

  /// Disposes the HTTP client.
  void dispose() {
    _client.close();
  }
}
