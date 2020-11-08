import 'package:dio/dio.dart';
import 'package:meu_campo/app/exceptions/rest_exception.dart';
import 'package:meu_campo/app/models/safra_model.dart';
import 'package:meu_campo/app/utils/custom_dio.dart';
import 'package:meu_campo/app/view_models/create_safra_model.dart';

class SafraRepository {
  var dio = CustomDio.whithAuthentication().instance;
  Future<List<SafraModel>> findAllSafrasUser(int idUser) async {
    try {
      final res = await dio.get('http://10.0.2.2:3333/users/$idUser/safras');
      return (res.data as List)
          .map((item) => SafraModel.fromJson(item))
          .toList();
    } on DioError catch (e) {
      print(e);
      throw RestException('Nenhuma Safra econtrada');
    }
  }

  Future storeSafra(int idUser, String safra) async {
    try {
      final res = await dio.post('http://10.0.2.2:3333/users/$idUser/safras',
          data: {'ano_safra': safra});
      print(res.data);
      print('passou store');
      //return (res.data);
      //return (res.data as List)
      //    .map((item) => SafraModel.fromJson(item))
      //    .toList();
      //return SafraModel.fromMap(res.data);
      //return res.data.map<SafraModel>((o) => SafraModel.fromMap(o)).toList();
      //===

      return (res.data as List)
          .map((item) => SafraModel.fromJson(item))
          .toList();
    } on DioError catch (e) {
      print('erro dio');

      print(e);
      throw RestException('Erro ao Cadastrar a Safra');
    }
  }
}
