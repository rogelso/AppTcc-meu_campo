import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:meu_campo/app/modules/auth/view/login_page.dart';
import 'package:meu_campo/app/modules/cargas/view/cargas_page.dart';
import 'package:meu_campo/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:meu_campo/app/modules/dashboard/view/dashboard_page.dart';
import 'package:meu_campo/app/modules/safra/view/safra_page.dart';
import 'package:meu_campo/app/modules/safra/view/select_safra_2_dialog.dart';
import 'package:meu_campo/app/modules/home/controllers/home_controller.dart';
import 'package:meu_campo/app/modules/safra/view/new_safra_dialog.dart';
import 'package:meu_campo/app/modules/splash/view/splash_page.dart';
import 'package:meu_campo/app/modules/talhoes_safra/view/talhoes_safra_page.dart';

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
  String dropdownValue = 'One';
  // ignore: avoid_init_to_null
  String nome = null;
  // ignore: avoid_init_to_null
  String sobrenome = null;
  // ignore: avoid_init_to_null
  String email = null;

  @override
  void initState() {
    super.initState();
    controller = context.read<HomeController>();
    context.read<HomeController>().getUser();
    controller.tabController = TabController(vsync: this, length: 4);
    context.read<HomeController>().getSafras();

    nome = controller.user.nome.toString();
    sobrenome = controller.user.sobrenome.toString();
    email = controller.user.email.toString();

    controller.addListener(() {
      print('QQQQQQQQQQQQQQQQQQQQQQQQ');
      print(controller.teste.toString());
      print(controller.safraSelected);
      //print(controller.);

      //userData = controller.user;
      //print(controller.user.toList());
      //controller.user.forEach((element) => print(element.nome));
      //print(_userData.nome);

      //safraSelected = controller.safraSelected;
      //print('safra selected');
      //print(safraSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              print('abriu select choose safra');
              print('safrass home page select');
              print(controller.safras.length);
              if (controller.safras.length != 0) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      //print(controller.safras);
                      //print(controller.teste);
                      return SelectSafra2Dialog(controller.safras);
                      //return Text(controller.user.cidade); //esse da certo
                    });
              }
            },
          ),
        ]),
      ),
      drawer: Drawer(
          //Consumer<HomeController>(builder: (_, controller, __) {}),
          child: ListView(children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(nome.toString() + ' ' + sobrenome.toString()),
          accountEmail: Text(email.toString()),
          //accountName: Text('controller.user.nome'),
          //accountEmail: Text('email.toString()'),
          currentAccountPicture: new CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/user.png',
            ),
          ),
        ),
        new ListTile(
          leading: Icon(
            FontAwesome.map_o,
            color: Colors.green[900],
          ),
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
          // leading: Material(
          //   color: Colors.green[900],
          //   shape: CircleBorder(side: BorderSide(color: Colors.white)),
          //   child: Icon(
          //     Icons.add_circle,
          //     color: Colors.white,
          //   ),
          // ),
          leading: Icon(
            FontAwesome.plus_circle,
            color: Colors.lightGreen[900],
          ),
          title: new Text('Nova Safra'),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  //print(controller.safras);
                  //print(controller.teste);
                  return NewSafraDialog();
                  //return Text(controller.user.cidade); //esse da certo
                });
          },
        ),
        new Divider(
          color: Colors.black,
          height: 5.0,
        ),
        new ListTile(
          leading: Icon(
            Icons.shopping_cart,
            color: Colors.blue[900],
          ),
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
          leading: Icon(
            Icons.new_releases,
            color: Colors.yellow[900],
          ),
          title: new Text('Notícias e Cotações'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        new Divider(
          color: Colors.black,
          height: 5.0,
        ),
        new ListTile(
          title: new Text('Sair'),
          onTap: () async {
            showAlertDialogExit(context);
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
            //ChangeNotifierProvider(create: (_) => MyOrdersController()),  //ficou safra page
            //ChangeNotifierProvider(
            //  create: (_) => ShoppingCardController(), //fioou talhoes safra page
            //),
          ],
          child: TabBarView(
            controller: controller.tabController,
            children: [
              DashboardPage(),
              SafraPage(),
              TalhoesSafraPage(),
              CargasPage()
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialogExit(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("SAIR"),
      onPressed: () async {
        final sp = await SharedPreferences.getInstance();
        sp.clear();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginPage.router, (route) => false);
      },
    );
    Widget cancelaButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("SAIR"),
      content: Text("Deseja sair da Conta?"),
      actions: [
        cancelaButton,
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
