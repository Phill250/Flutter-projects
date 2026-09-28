import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:vroom/service/auth_api.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:vroom/model/auth_exception.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late AuthApi authApi;

  setUp(() {
    mockHttpClient = MockHttpClient();
    authApi = AuthApi(client: mockHttpClient);
    registerFallbackValue(Uri.parse("https://dummy.url"));
  });

  group('login', () {
    test('returns AuthResult on success', () async {
      final dummyResponse = {
        'id': 1,
        'username': 'Jack',
        'email': 'jack@beanstalk.com',
        'firstName': 'Jack',
        'lastName': 'Beanstalk',
        'image': 'http:image.link',
        'gender': 'male',
        'accessToken': 'dummyAccessToken',
        'refreshToken': 'dummyRefreshToken',
      };

      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(dummyResponse), 200));

      final result = await authApi.login('Jack', 'password');
      expect(result.accessToken, 'dummyAccessToken');
      expect(result.user.firstName, 'Jack');
      expect(result.user.lastName, 'Beanstalk');
      expect(result.user.email, 'jack@beanstalk.com');
      expect(result.user.image, 'http:image.link');
      expect(result.user.gender, 'male');
    });

    test('test failed login', () async {
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(jsonEncode({'message': 'Invalid credentials'}), 400),
      );

      expect(
        () => authApi.login('Jack', 'wrongpassword'),
        throwsA(
          isA<AuthException>().having(
            (e) => e.toString(),
            'message',
            contains('Invalid credentials'),
          ),
        ),
      );
    });
  });
}
