import 'package:flutter/material.dart';
import 'package:meu_campo/app/exceptions/rest_exception.dart';
import 'package:meu_campo/app/repositories/auth_repository.dart';
import 'package:meu_campo/app/view_models/register_input_model.dart';

class RegisterController extends ChangeNotifier {
  bool loading;
  bool registerSuccess;
  String error;
  final AuthRepository _repository = AuthRepository();

  Future<void> registerUser(String nome, String sobrenome, String email,
      String password, String cidade, String uf) async {
    loading = true;
    registerSuccess = false;
    notifyListeners();
    final inputModel = RegisterInputModel(
        nome: nome,
        sobrenome: sobrenome,
        email: email,
        password: password,
        cidade: cidade,
        uf: uf);

    try {
      await _repository.saveUser(inputModel);
      registerSuccess = true;
    } on RestException catch (e) {
      registerSuccess = false;
      error = e.message;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
