import 'package:flutter/material.dart';
import 'package:meu_campo/app/exceptions/rest_exception.dart';
import 'package:meu_campo/app/models/safra_model.dart';
import 'package:meu_campo/app/models/user_model.dart';
import 'package:meu_campo/app/modules/home/view/home_page.dart';
import 'package:meu_campo/app/repositories/safra_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

//enum SafraSelect { selected, unSelected }

class SafraController extends ChangeNotifier {
  SafraRepository _repository = SafraRepository();
  List<SafraModel> safras = [];
  SafraModel nSafra;
  bool loading = false;
  String error;
  String errorLoadData;
  // SafraSelect safraSelected;
  bool showLoader;

  bool loginSuccess;
  final _safraRepository = SafraRepository();

  List<SafraModel> newSafra = [];

  Future<void> getAllSafrasUser() async {
    loading = true;
    error = null;
    errorLoadData = null;

    notifyListeners();
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final user = UserModel.fromJson(sp.getString('user'));

      safras = await _repository.findAllSafrasUser(user.id);
      print('777777');
      //print(safras);
    } on RestException catch (e) {
      errorLoadData = e.message;
    } catch (e) {
      print(e);
      // error = 'Erro ao Buscar As Demontrações Financeiras';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> createNewSafra(BuildContext context, String safra) async {
    print('createNewSafra');
    print(safra);
    showLoader = true;
    error = null;
    loginSuccess = false;
    notifyListeners();
    try {
      final sp = await SharedPreferences.getInstance();
      final user = UserModel.fromJson(sp.getString('user'));

      newSafra = await _safraRepository.storeSafra(user.id, safra);

      if (newSafra[0] != null) {
        sp.remove('unSelected');
        sp.setInt('id_safra', newSafra[0].id);
        sp.setString('safra', newSafra[0].anoSafra);

        showLoader = false;
        loginSuccess = true;
        notifyListeners();

        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.router, (route) => false);
      } else {
        error = 'Erro ao criar a safra';
      }
    } on RestException catch (e) {
      error = e.message;
      showLoader = false;
      print('erro');
    } catch (e) {
      error = 'Erro ao criar a safra';
      showLoader = false;
    } finally {
      notifyListeners();
    }
  }
}
