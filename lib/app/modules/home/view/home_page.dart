import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:meu_campo/app/models/safra_model.dart';
import 'package:meu_campo/app/models/user_model.dart';
import 'package:meu_campo/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:meu_campo/app/modules/dashboard/view/dashboard_page.dart';
import 'package:meu_campo/app/modules/dashboard/view/select_safra_dialog.dart';
import 'package:meu_campo/app/modules/home/controllers/home_controller.dart';
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
  UserModel _userData;
  String dropdownValue = 'One';

  List<SafraModel> safrass = [];

  @override
  void initState() {
    super.initState();
    controller = context.read<HomeController>();
    context.read<HomeController>().getUser();
    controller.tabController = TabController(vsync: this, length: 4);

    var controller2 = context.read<HomeController>();
    context.read<HomeController>().getSafras();

    controller.addListener(() {
      print('QQQQQQQQQQQQQQQQQQQQQQQQ');
      print(controller.teste.toString());
      print(controller.safraSelected);
      //print(controller.);

      _userData = controller.user;
      //userData = controller.user;
      //print(controller.user.toList());
      //controller.user.forEach((element) => print(element.nome));
      print(_userData.nome);

      //safraSelected = controller.safraSelected;
      //print('safra selected');
      //print(safraSelected);

      safrass = controller.safras;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: ValueListenableBuilder(
      //     valueListenable: _tabSelected,
      //     builder: (_, _tabSelectedValue, child) {
      //       return Text(_titles[_tabSelectedValue]);
      //     },
      //   ),
      // ),
      appBar: AppBar(
        //title: Text(safraSelected.toString()),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Consumer<HomeController>(builder: (_, controller, __) {
            return Text(controller.safraSelected);
          }),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 27,
            tooltip: 'Show Snackbar',
            onPressed: () {
              // context.read<DashboardController>().checkSelectedSafra();
              // Consumer<DashboardController>(builder: (_, controller, __) {
              //   showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         // return SelectSafraDialog();
              //         //return SelectSafraDialog(controller.safras);
              //         //return Text(controller.user.cidade);
              //         print('select safra');
              //       });
              // });
              //var safrass = controller.getSafras();

              print('safrass home page select');
              print(safrass.length);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    print(controller.safras);
                    return SelectSafraDialog(controller.safras);
                    //return Text(controller.user.cidade); //esse da certo
                  });

              print('abrir select');
            },
          ),
        ]),
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        //Consumer<HomeController>(builder: (_, controller, __) {}),
        new UserAccountsDrawerHeader(
          accountName: new Text('_userData.nome'),
          accountEmail: new Text('teste@teste.com'),
          currentAccountPicture: new CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/user.png',
            ),
          ),
        ),
        new ListTile(
          title: new Text('Meus Talhões'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        new Divider(
          color: Colors.black,
          height: 5.0,
        ),
        new ListTile(
          title: new Text('Nova Safra'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        new Divider(
          color: Colors.black,
          height: 5.0,
        ),
        new ListTile(
          title: new Text('Estoque de Produtos'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        new Divider(
          color: Colors.black,
          height: 5.0,
        ),
        new ListTile(
          title: new Text('Notícias e Cotações'),
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
          Icon(Icons.photo_size_select_actual),
          Icon(FontAwesome.truck),
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
              create: (_) => DashboardController()..findControleFinanceiro(),
            ),
            ChangeNotifierProvider(create: (_) => MyOrdersController()),
            ChangeNotifierProvider(
              create: (_) => ShoppingCardController(),
            ),
          ],
          child: TabBarView(
            controller: controller.tabController,
            children: [
              DashboardPage(),
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
