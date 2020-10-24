import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_campo/app/models/order_model.dart';
import 'package:meu_campo/app/modules/my_orders/controller/my_orders_controller.dart';
import 'package:meu_campo/app/shared/mixins/loader_mixin.dart';
import 'package:meu_campo/app/shared/mixins/messages_mixin.dart';

import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage>
    with LoaderMixin, MessagesMixin {
  final formatNumberPrice =
      NumberFormat.currency(name: 'R\$', locale: 'pt_BR', decimalDigits: 2);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (this.mounted) {
        context.read<MyOrdersController>().findAll();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: RefreshIndicator(
      //   onRefresh: () => context.read<MyOrdersController>().findAll(),
      //   child: Consumer<MyOrdersController>(
      //     builder: (_, controller, __) {
      //       if (controller.loading) {
      //         return ListView(
      //           children: [Center(child: CircularProgressIndicator())],
      //         );
      //       }

      //       if (!isNull(controller.error)) {
      //         return ListView(
      //           children: [
      //             Center(
      //                 child: Text(
      //                     'Erro ao buscar pedidos tente novamente mais tarde')),
      //             RaisedButton(
      //               onPressed: () => controller.findAll(),
      //               child: Text('Tentar novamente'),
      //             )
      //           ],
      //         );
      //       }

      //       return ListView.builder(
      //         itemCount: controller?.orders?.length ?? 0,
      //         itemBuilder: (context, index) {
      //           final order = controller.orders[index];
      //           return ExpansionTile(
      //             title: Text('Pedido ${order.id}'),
      //             children: [
      //               Divider(),
      //               ...order.items.map<Widget>((o) {
      //                 return Container(
      //                   padding: EdgeInsets.symmetric(
      //                     horizontal: 20,
      //                     vertical: 5,
      //                   ),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Text(o?.item?.name ?? ''),
      //                       Text(
      //                         formatNumberPrice.format(o.item.price),
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               }).toList(),
      //               Divider(),
      //               Container(
      //                 padding: EdgeInsets.symmetric(
      //                   horizontal: 20,
      //                   vertical: 5,
      //                 ),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text('Total'),
      //                     Text(
      //                       _calculateTotalOrder(order),
      //                     ),
      //                   ],
      //                 ),
      //               )
      //             ],
      //           );
      //         },
      //       );
      //     },
      //   ),
      // ),
      body: Container(
        child: Center(
          child: Text(
            "Safra",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  String _calculateTotalOrder(OrderModel order) {
    final totalOrder = order.items.fold(
        0.0, (totalValue, orderItem) => totalValue += orderItem.item.price);
    return formatNumberPrice.format(totalOrder);
  }
}
