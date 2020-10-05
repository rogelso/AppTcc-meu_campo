import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:meu_campo/app/modules/home/controllers/home_controller.dart';
import 'package:meu_campo/app/modules/shopping_card/components/shopping_card_item.dart';
import 'package:meu_campo/app/modules/shopping_card/controller/shopping_card_controller.dart';
import 'package:meu_campo/app/shared/components/pizza_delivery_button.dart';
import 'package:meu_campo/app/shared/mixins/loader_mixin.dart';
import 'package:meu_campo/app/shared/mixins/messages_mixin.dart';

import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class ShoppingCardPage extends StatefulWidget {
  @override
  _ShoppingCardPageState createState() => _ShoppingCardPageState();
}

class _ShoppingCardPageState extends State<ShoppingCardPage>
    with LoaderMixin, MessagesMixin {
  final numberFormat =
      NumberFormat.currency(name: 'R\$', locale: 'pt_BR', decimalDigits: 2);
  final addressEditingController = TextEditingController();
  final paymentTypeSelected = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final controller = context.read<ShoppingCardController>();
      controller.loadPage();
      controller.addListener(() async {
        if (this.mounted) {
          showHideLoaderHelper(context, controller.loading);

          if (!isNull(controller.error)) {
            showError(context: context, message: controller.error);
          }

          if (controller.success) {
            showSuccess(
                context: context, message: 'Pedido realizado com sucesso');
            Future.delayed(Duration(seconds: 1), () {
              controller.clearShoppingCard();
              context.read<HomeController>().changeTab(1);
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ShoppingCardController>(
        builder: (_, controller, __) {
          return !controller.hasItemSelected
              ? _buildClearShoppingCard(context)
              : Column(
                  children: [
                    ListTile(
                      title: Text('Nome'),
                      subtitle: Text(controller?.user?.nome ?? ''),
                    ),
                    Divider(),
                    _buildShoppingCardItems(context, controller),
                    Divider(),
                    ListTile(
                      title: Text('Endereço de Entrega'),
                      subtitle: Text(controller.address ?? ''),
                      trailing: FlatButton(
                          onPressed: () => changeAddress(),
                          child: Text('alterar',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Tipo de Pagamento'),
                      subtitle: Text(controller.paymentType),
                      trailing: FlatButton(
                        onPressed: () => changePaymentType(),
                        child: Text(
                          'alterar',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    Divider(),
                    Expanded(child: Container()),
                    PizzaDeliveryButton(
                      'Finalizar Pedido',
                      width: MediaQuery.of(context).size.width * .9,
                      height: 50,
                      buttonColor: Theme.of(context).primaryColor,
                      labelSize: 18,
                      labelColor: Colors.white,
                      onPressed: () => controller.checkout(),
                    ),
                    SizedBox(height: 20),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildShoppingCardItems(
      BuildContext context, ShoppingCardController controller) {
    final items = controller.itemsSelected.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Pedido',
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 10),
        ...items.map<ShoppingCardItem>((i) => ShoppingCardItem(i)).toList(),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total'),
              Text(numberFormat.format(controller.totalPrice))
            ],
          ),
        ),
        FlatButton(
          onPressed: () => controller.clearShoppingCard(),
          child: Text(
            'Limpar Carrinho',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildClearShoppingCard(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Icon(AntDesign.shoppingcart, size: 200),
        Text('Seu carrinho está vazio')
      ],
    ));
  }

  void changeAddress() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Endereço de Entrega'),
            content: TextField(
              controller: addressEditingController,
            ),
            actions: [
              RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar')),
              RaisedButton(
                  onPressed: () {
                    context
                        .read<ShoppingCardController>()
                        .changeAddress(addressEditingController.text);
                    Navigator.pop(context);
                  },
                  child: Text('Alterar')),
            ],
          );
        });
  }

  void changePaymentType() {
    showDialog(
        context: context,
        builder: (_) {
          final controller = context.read<ShoppingCardController>();
          paymentTypeSelected.value = controller.paymentType;
          return AlertDialog(
            title: Text('Tipo de Pagamento'),
            content: Container(
              height: 150,
              child: ValueListenableBuilder(
                valueListenable: paymentTypeSelected,
                builder: (_, paymentTypeSelectedValue, child) {
                  // return RadioButtonGroup(
                  //   picked: paymentTypeSelectedValue,
                  //   labels: <String>[
                  //     'Cartão de Crédito',
                  //     'Cartão de Débito',
                  //     'Dinheiro',
                  //   ],
                  //   onSelected: (String selected) {
                  //     paymentTypeSelected.value = selected;
                  //   },
                  // );
                },
              ),
            ),
            actions: [
              RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar')),
              RaisedButton(
                  onPressed: () {
                    context
                        .read<ShoppingCardController>()
                        .changePaymentType(paymentTypeSelected.value);
                    Navigator.pop(context);
                  },
                  child: Text('Alterar')),
            ],
          );
        });
  }
}
