import 'package:flutter/material.dart';
import 'package:meu_campo/app/exceptions/rest_exception.dart';
import 'package:meu_campo/app/models/order_model.dart';
import 'package:meu_campo/app/models/user_model.dart';
import 'package:meu_campo/app/repositories/orders_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MyOrdersController extends ChangeNotifier {
  bool loading = false;
  String error;
  List<OrderModel> orders = [];
  final _repository = OrdersRepository();

  Future<void> findAll() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final user = UserModel.fromJson(sp.getString('user'));
      orders = await _repository.findMyOrders(user.id);
    } on RestException catch (e) {
      error = e.message;
    } catch (e) {
      print(e);
      error = 'Erro ao buscar meus pedidos';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
