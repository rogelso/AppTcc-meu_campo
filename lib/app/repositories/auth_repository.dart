import 'package:dio/dio.dart';
import 'package:meu_campo/app/exceptions/rest_exception.dart';
import 'package:meu_campo/app/models/user_model.dart';
import 'package:meu_campo/app/utils/custom_dio.dart';
import 'package:meu_campo/app/view_models/register_input_model.dart';

class AuthRepository {
  var dio = CustomDio().instance;

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post('http://10.0.2.2:3333/login',
          data: {'email': email, 'password': password});
      return UserModel.fromMap(response.data);
    } on DioError catch (e) {
      print(e);
      String message = 'Erro ao autenticar usuário';
      if (e?.response?.statusCode == 403) {
        message = 'Usuário ou senha inválidos';
      }
      if (e?.response?.statusCode == 400) {
        message = 'Falha na conexão com o servidor';
      }
      throw RestException(message);
    }
  }

  Future<void> saveUser(RegisterInputModel registerInputModel) async {
    try {
      await Dio().post('http://10.0.2.2:3333/users/register', data: {
        'nome': registerInputModel.nome,
        'sobrenome': registerInputModel.sobrenome,
        'email': registerInputModel.email,
        'password': registerInputModel.password,
        'cidade': registerInputModel.email,
        'uf': registerInputModel.uf
      });
    } on DioError catch (e) {
      print(e);
      throw RestException('Erro ao registrar usuário');
    }
  }
}
