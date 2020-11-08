import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:meu_campo/app/models/safra_model.dart';

import 'package:meu_campo/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:meu_campo/app/modules/safra/view/select_safra_dialog.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final formatNumberPrice =
      NumberFormat.currency(name: 'R\$', locale: 'pt_BR', decimalDigits: 2);

  String teste;
  List<SafraModel> safrass = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (this.mounted) {
        //context.read<DashboardController>().findControleFinanceiro();
        print('teste');
      }
    });

    var controller = context.read<DashboardController>();
    context.read<DashboardController>().checkSelectedSafra();

    controller.addListener(() {
      safrass = controller.safras;
      safrass.forEach((element) => print(element.anoSafra));
      //print(safrass);
      print('qqi');
      switch (controller.safraSelected) {
        case SafraSelect.unSelected:
          print("pegou o não selecionado");
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (this.mounted) {
              print('chamou o dialog');
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SelectSafraDialog(safrass);
                    //return SelectSafraDialog();
                  });
            }
          });

          // showAlertDialog1(context);
          // show diagon estava aqui fora trazia dados ao mudar
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil(RegisterPage.router, (route) => false);
          break;
        case SafraSelect.selected:
          print("pegou o selecionado");
          teste = 'teste';
          break;

        case SafraSelect.nonexistent:
          print("pegou o não existe");
          teste = 'teste';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: RefreshIndicator(
          onRefresh: () =>
              context.read<DashboardController>().findControleFinanceiro(),
          child: Consumer<DashboardController>(
            builder: (_, controller, __) {
              if (controller.loading) {
                return ListView(
                  children: [Center(child: CircularProgressIndicator())],
                );
              }

              if (controller.errorLoadData != null) {
                return Text(controller.errorLoadData);
              }

              return ListView.builder(
                itemCount: controller?.demonstration?.length ?? 0,
                itemBuilder: (context, index) {
                  final demonstrations = controller.demonstration[index];
                  return ExpansionTile(
                    title: Text('Visualizar Demontrações Financeiras'),
                    leading: Icon(
                      FontAwesome.line_chart,
                      size: 36.0,
                      //color: Colors.black,
                    ),
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 1,
                          color: Colors.grey[300],
                        )),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Receita Bruta Total:'),
                            Text(formatNumberPrice
                                .format(demonstrations.receitaBrutaTotal)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Deduções Impostos Totais:'),
                            Text(formatNumberPrice
                                .format(demonstrations.deducoesImpostosTotal)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Receita Líquida Total:'),
                            Text(formatNumberPrice
                                .format(demonstrations.receitaLiquidaTotal)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Custos Variáveis Totais: '),
                            Text(formatNumberPrice
                                .format(demonstrations.custosVariaveisTotal)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Lucro Bruto: '),
                            Text(formatNumberPrice
                                .format(demonstrations.lucroBruto)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Gastos Fixos Operacionais:'),
                            Text(formatNumberPrice.format(
                                demonstrations.gastosFixosOperacionais)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Lucro Líquido: '),
                            Text(formatNumberPrice
                                .format(demonstrations.lucroLiquido)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Depreciações: '),
                            Text(formatNumberPrice
                                .format(demonstrations.custosDepreciacoes)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Lucro Líquido - Depreciações: '),
                            Text(formatNumberPrice.format(
                                demonstrations.lucroLiquido -
                                    demonstrations.custosDepreciacoes)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

showAlertDialog1(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
      print('demonho');
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Promoção Imperdivel"),
    content: Text("Não perca a promoção."),
    actions: [
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

showAlertDialog3(BuildContext context) {
  // configura os botões
  Widget lembrarButton = FlatButton(
    child: Text("Lembrar"),
    onPressed: () {},
  );
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed: () {},
  );
  Widget dispararButton = FlatButton(
    child: Text("Disparar"),
    onPressed: () {},
  );
  // configura o  AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Aviso"),
    content: Text("Disparar este míssil vai destruir o mundo."),
    actions: <Widget>[
      lembrarButton,
      cancelaButton,
      dispararButton,
    ],
  );
  // exibe o dialogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
