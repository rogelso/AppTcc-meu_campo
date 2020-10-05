import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:meu_campo/app/modules/home/controllers/home_controller.dart';
import 'package:meu_campo/app/modules/menu/controller/menu_controller.dart';
import 'package:meu_campo/app/modules/menu/view/menu_page.dart';
import 'package:meu_campo/app/modules/my_orders/controller/my_orders_controller.dart';
import 'package:meu_campo/app/modules/my_orders/view/my_orders_page.dart';
import 'package:meu_campo/app/modules/shopping_card/controller/shopping_card_controller.dart';
import 'package:meu_campo/app/modules/shopping_card/view/shopping_card_page.dart';
import 'package:meu_campo/app/modules/splash/view/splash_page.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  static const router = '/home';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  HomeController controller;
  final _tabSelected = ValueNotifier<int>(0);
  final _titles = ['Finanças', 'Safra', 'Talhões em Cultivo', 'Cargas'];

  @override
  void initState() {
    super.initState();
    controller = context.read<HomeController>();
    controller.tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: _tabSelected,
          builder: (_, _tabSelectedValue, child) {
            return Text(_titles[_tabSelectedValue]);
          },
        ),
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text('teste'),
          accountEmail: new Text('teste@teste.com'),
          currentAccountPicture: new CircleAvatar(
            backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
          ),
        ),
        new ListTile(
          title: new Text('Meus Produtos'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        new Divider(
          color: Colors.black,
          height: 5.0,
        ),
        new ListTile(
          title: new Text('Minha Safra'),
          onTap: () {
            Navigator.of(context).pop();
          },
        )
      ])),
      bottomNavigationBar: CurvedNavigationBar(
        key: controller.bottomNavigationKey,
        backgroundColor: Colors.white,
        height: 60,
        color: Theme.of(context).primaryColor,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Image.asset(
            'assets/images/icon_financas.png',
            width: 30,
          ),
          Icon(FontAwesome.list),
          Icon(Icons.shopping_cart),
          Icon(Icons.menu),
        ],
        onTap: (index) {
          _tabSelected.value = index;
          controller.tabController.animateTo(index);
        },
      ),
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => MenuController()..findMenu(),
            ),
            ChangeNotifierProvider(create: (_) => MyOrdersController()),
            ChangeNotifierProvider(
              create: (_) => ShoppingCardController(),
            )
          ],
          child: TabBarView(
            controller: controller.tabController,
            children: [
              MenuPage(),
              MyOrdersPage(),
              ShoppingCardPage(),
              FlatButton(
                onPressed: () async {
                  final sp = await SharedPreferences.getInstance();
                  sp.clear();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SplashPage.router, (route) => false);
                },
                child: Text('Sair', style: TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
