import 'package:dio/dio.dart';
import 'package:meu_campo/app/exceptions/rest_exception.dart';
import 'package:meu_campo/app/models/dashboard_model.dart';
import 'package:meu_campo/app/utils/custom_dio.dart';

class DashboardRepository {
  var dio = CustomDio.whithAuthentication().instance;
  Future<List<DashboardModel>> findMyDemonstration(
      int idUser, int idSafra) async {
    if (idSafra == null) {
      idSafra = 0;
    }
    try {
      final res = await dio
          .get('http://10.0.2.2:3333/users/$idUser/safra/$idSafra/dashboard');
      return (res.data as List)
          .map((item) => DashboardModel.fromJson(item))
          .toList();
    } on DioError catch (e) {
      print(e);
      throw RestException('Nenhuma Demostração Financeira encontrada!');
    }
  }
}
