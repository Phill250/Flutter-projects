class AuthException {
  final String message;

  AuthException(this.message);

  @override
  String toString(){
    return message;
  }
}