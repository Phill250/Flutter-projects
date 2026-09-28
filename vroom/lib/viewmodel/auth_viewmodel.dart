import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/model/auth_exception.dart';
import 'package:vroom/service/auth_api.dart';
import 'package:vroom/model/user.dart';

enum AuthStatus{authenticated, unauthenticated}

class AuthViewModel extends ChangeNotifier{
  late AuthApi _authApi;
  User? user;
  String ? errorMessage;
  bool isLoading = false;
  static const String ACCESS_TOKEN_KEY = 'ACCESS_TOKEN_KEY';
  static const String REFRESH_TOKEN_KEY = 'REFRESH_TOKEN_KEY';
  AuthStatus authStatus = AuthStatus.unauthenticated;





  AuthViewModel({AuthApi ? authApi}){
    _authApi = authApi ?? AuthApi();
    autoLogin();
  }

  Future<bool> login(String username, String password) async{
    isLoading = true;
    notifyListeners();
    bool success = false;
    try{
      var result = await _authApi.login(username, password);
      String accessToken = result.accessToken;
      String refreshToken = result.refreshToken;
      await saveTokens(accessToken, refreshToken);
      authStatus = AuthStatus.authenticated;
      success = true;

    } on AuthException catch (e) {
      errorMessage = e.message;
      authStatus = AuthStatus.unauthenticated;
      success = false;

    }
    catch (e) {
      errorMessage = e.toString();
      authStatus = AuthStatus.unauthenticated;
      success = false;

    }
    finally{
      isLoading = false;
      notifyListeners();
    }
    return success;
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN_KEY, accessToken);
    await prefs.setString(REFRESH_TOKEN_KEY, refreshToken);

  }
  Future<void> autoLogin() async{
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(ACCESS_TOKEN_KEY);
    String? refreshTOken = prefs.getString(REFRESH_TOKEN_KEY);

    //no token

    if(accessToken==null || refreshTOken==null){
      authStatus = AuthStatus.unauthenticated;
      return;
    }
    
    //attempt to get current user
    // if response is successful, token is valid, mark the user as authenticated
    //else use the refresh token to obtain a fresh accecsstoken
    try{
      final success = await _authApi.fetchCurrentUser(accessToken);
      if(success){
        authStatus = AuthStatus.authenticated;
        notifyListeners();
      }else{
        final tokens = await _authApi.refresh(refreshTOken);
        accessToken = tokens.accessToken;
        refreshTOken = tokens.refreshToken;
        await saveTokens(accessToken, refreshTOken);
        authStatus = AuthStatus.authenticated;
        notifyListeners();
      }

    }
    catch(e){ 
      final tokens = await _authApi.refresh(refreshTOken!);
        accessToken = tokens.accessToken;
        refreshTOken = tokens.refreshToken;
        await saveTokens(accessToken, refreshTOken);
        authStatus = AuthStatus.authenticated;
        notifyListeners();

    }

    notifyListeners();
  }

  Future<void> logout() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(ACCESS_TOKEN_KEY);
    prefs.remove(REFRESH_TOKEN_KEY);
    authStatus = AuthStatus.unauthenticated;
    notifyListeners();

  }
}