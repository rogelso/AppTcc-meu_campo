import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:meu_campo/app/models/safra_model.dart';
import 'package:meu_campo/app/models/user_model.dart';
import 'package:meu_campo/app/repositories/safra_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  TabController tabController;
  GlobalKey bottomNavigationKey = GlobalKey();
  UserModel user;
  String teste;
  String safraSelected = 'Nenhuma Safra Ativa';

  List<SafraModel> safras = [];
  SafraRepository _repository = SafraRepository();

  void changeTab(int page) {
    tabController.index = page;
    CurvedNavigationBarState state = bottomNavigationKey.currentState;
    state.setPage(page);
  }

  void getUser() async {
    print('chamou get user');
    SharedPreferences sp = await SharedPreferences.getInstance();
    user = UserModel.fromJson(sp.getString('user'));
    print(user);
    teste = 'var test get user';

    //print(teste);
    //return user;
    //return user;
    if (sp.containsKey('id_safra')) {
      safraSelected = sp.getString('safra');
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> getSafras() async {
    final sp = await SharedPreferences.getInstance();
    //final idSafra = sp.get('id_safra');
    final user = UserModel.fromJson(sp.getString('user'));
    safras = await _repository.findAllSafrasUser(user.id);
    print(safras.length);
    print('get_safras');
  }
}
