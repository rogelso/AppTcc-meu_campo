import 'package:flutter/material.dart';
import 'package:meu_campo/app/exceptions/rest_exception.dart';
import 'package:meu_campo/app/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  bool showLoader;
  String error;
  bool loginSuccess;
  final _authRepository = AuthRepository();

  Future<void> login(String email, String password) async {
    showLoader = true;
    error = null;
    loginSuccess = false;
    notifyListeners();
    try {
      final user = await _authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();

      sp.setString('user', user.toJson());
      sp.setString('token', user.token);
      print(user.token);
      print('token acima');
      showLoader = false;
      loginSuccess = true;
    } on RestException catch (e) {
      error = e.message;
      showLoader = false;
    } catch (e) {
      error = 'Erro ao autenticar usuário';
      showLoader = false;
    } finally {
      notifyListeners();
    }
  }
}
