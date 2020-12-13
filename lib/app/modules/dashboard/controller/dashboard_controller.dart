import 'package:flutter/material.dart';
import 'package:meu_campo/app/exceptions/rest_exception.dart';
import 'package:meu_campo/app/models/dashboard_model.dart';
import 'package:meu_campo/app/models/safra_model.dart';
import 'package:meu_campo/app/models/user_model.dart';
import 'package:meu_campo/app/modules/home/view/home_page.dart';
import 'package:meu_campo/app/repositories/dashboard_repository.dart';
import 'package:meu_campo/app/repositories/safra_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SafraSelect { selected, unSelected, nonexistent }

class DashboardController extends ChangeNotifier {
  DashboardRepository _repository = DashboardRepository();
  List<DashboardModel> demonstration = [];
  SafraRepository _repository2 = SafraRepository();
  List<SafraModel> safras = [];
  bool loading = false;
  String error;
  String errorLoadData;
  SafraSelect safraSelected;
  bool showLoader;

  Future<void> findControleFinanceiro() async {
    loading = true;
    error = null;
    errorLoadData = null;

    notifyListeners();
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final user = UserModel.fromJson(sp.getString('user'));

      final idSafra = sp.get('id_safra');

      demonstration = await _repository.findMyDemonstration(user.id, idSafra);
    } on RestException catch (e) {
      errorLoadData = e.message;
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> checkSelectedSafra() async {
    final sp = await SharedPreferences.getInstance();
    //final idSafra = sp.get('id_safra');
    final user = UserModel.fromJson(sp.getString('user'));
    safras = await _repository2.findAllSafrasUser(user.id);
    print(safras.length);
    //-
    if (safras.length == 0) {
      print('entrou no não tem safras');
      safraSelected = SafraSelect.nonexistent;
    } else if (sp.containsKey('unSelected')) {
      print('entrou no unSelected');
      if (safras.length != 0) safraSelected = SafraSelect.unSelected;
    } else if (sp.containsKey('id_safra')) {
      print('achou o id_safra');
      safraSelected = SafraSelect.selected;
    }

    notifyListeners();
  }

  Future<void> setSelectSafra(
      BuildContext context, int idSafra, String safra) async {
    notifyListeners();
    try {
      print('idSadra selecionado');
      print(idSafra);
      final sp = await SharedPreferences.getInstance();
      sp.remove('unSelected');
      sp.setInt('id_safra', idSafra);
      sp.setString('safra', safra);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomePage.router, (route) => false);
    } catch (e) {} finally {
      notifyListeners();
    }
  }
}
