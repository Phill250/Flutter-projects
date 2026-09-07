import 'package:mocktail/mocktail.dart';
import 'package:vroom/service/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vroom/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/model/auth_exception.dart';
import 'package:vroom/model/login_response.dart';
import 'package:vroom/viewmodel/auth_viewmodel.dart';


class MockAuthApi extends Mock implements AuthApi {}

User _mockUser = User(
  id: 1,
  username: 'Andy',
  email: 'andy@gmail.com',
  firstName: 'Andy',
  lastName: 'Laique',
  image: 'http:image.link',
  gender: 'female',
  );


  void main(){
    late MockAuthApi mockApi;


    setUpAll((){
      registerFallbackValue(_mockUser);
    });

    setUp((){
      mockApi = MockAuthApi();
    });

    group('login', (){
      test('test successful login', () async{

        SharedPreferences.setMockInitialValues({});
        when(()=> mockApi.login('Andy', 'password')).thenAnswer((_) async => LoginResponse(
          user: _mockUser,
          accessToken: 'dummyAccessToken',
          refreshToken: 'dummyRefreshToken',
          ),
        );

        final vm = AuthViewModel(authApi: mockApi);
        var success = await vm.login('Andy', 'password');

        expect(success, isTrue);
        expect(vm.authStatus, AuthStatus.authenticated);
       
      });

      test('test failed login', () async{
        SharedPreferences.setMockInitialValues({});
        when(()=> mockApi.login(any(), any()),
        ).thenThrow(AuthException('Invalid credentials'));

        final vm = AuthViewModel(authApi: mockApi);
        var success = await vm.login('wrong', 'wrongpassword');
        expect(success, isFalse);
        expect(vm.authStatus, AuthStatus.unauthenticated);
        expect(vm.errorMessage, contains('Invalid credentials'));

      });

    });



  }