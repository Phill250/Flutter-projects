import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vroom/model/auth_exception.dart';
import 'package:vroom/model/login_response.dart';
import 'package:vroom/model/token_response.dart';
import 'package:vroom/model/user.dart';

class AuthApi {
  final String baseUrl = "https://dummyjson.com";

  late http.Client _client;

  AuthApi({http.Client? client}) {
    _client = client ?? http.Client();
  }

  Future<LoginResponse> login(String username, String password) async {
    final response = await _client.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode != 200) {
      var body = jsonDecode(response.body);
      throw AuthException(body['message'] ?? 'Login Error');
    }

    var json = jsonDecode(response.body);
    return LoginResponse(
      user: User.fromJson(json),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Future<bool> fetchCurrentUser(String accessToken) async {
    final response = await _client.get(
      Uri.parse("$baseUrl/auth/me"),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode != 200) {
      var body = jsonDecode(response.body);
      throw AuthException(body['message'] ?? 'Token invalid');
    }
    return true;
  }

  Future<TokenResponse> refresh(String refreshToken) async {
    final response = await _client.post(
      Uri.parse("$baseUrl/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode != 200) {
      var body = jsonDecode(response.body);
      throw AuthException(body['message'] ?? 'Token refresh failed');
    }

    var json = jsonDecode(response.body);
    return TokenResponse(json['accessToken'], json['refreshToken']);
  }
}
