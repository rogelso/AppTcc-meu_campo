import 'package:flutter/material.dart';
import 'package:meu_campo/app/exceptions/rest_exception.dart';
import 'package:meu_campo/app/models/safra_model.dart';
import 'package:meu_campo/app/models/user_model.dart';
import 'package:meu_campo/app/repositories/safra_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

//enum SafraSelect { selected, unSelected }

class SafraController extends ChangeNotifier {
  SafraRepository _repository = SafraRepository();
  List<SafraModel> safras = [];
  bool loading = false;
  String error;
  String errorLoadData;
  // SafraSelect safraSelected;

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
}
