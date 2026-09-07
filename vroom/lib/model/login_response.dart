import 'package:vroom/model/user.dart';

class LoginResponse{
  final User user;
  final String accessToken, refreshToken;

  LoginResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

}