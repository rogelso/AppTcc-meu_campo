import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:meu_campo/app/models/safra_model.dart';
import 'package:meu_campo/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:meu_campo/app/shared/components/meu_campo_button.dart';

import 'package:meu_campo/app/shared/mixins/loader_mixin.dart';
import 'package:meu_campo/app/shared/mixins/messages_mixin.dart';

// ignore: must_be_immutable
class SelectSafra2Dialog extends StatefulWidget {
  List<SafraModel> safrass;
  SelectSafra2Dialog(this.safrass);

  //final safras = SafraController().getAllSafrasUser(); //esse chama

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<SelectSafra2Dialog>
    with LoaderMixin, MessagesMixin {
  String dropdownValue = 'One';

  List<ListItem> _dropdownItems = [];
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    print('init state safras dialog');
    print(widget.safrass.length);

    widget.safrass.forEach((element) => print(element.anoSafra));
    widget.safrass.forEach((element) =>
        _dropdownItems.add(ListItem(element.id, element.anoSafra)));
    //_dropdownItems.add(ListItem(4, "teste"));

    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  dialogContent(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            height: 30,
            child: Text(
              "Selecione uma de suas Safras",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  border: Border.all()),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: _selectedItem,
                    items: _dropdownMenuItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedItem = value;
                      });
                    }),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Divider(),
          SizedBox(height: 15.0),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MeuCampoButton(
                    'Cancelar',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    height: 28,
                    labelColor: Colors.white,
                    buttonColor: Colors.blueGrey,
                    width: MediaQuery.of(context).size.width * .2,
                    labelSize: 14,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MeuCampoButton(
                    'Selecionar',
                    onPressed: () {
                      DashboardController().setSelectSafra(
                          context, _selectedItem.value, _selectedItem.name);
                    },
                    height: 28,
                    labelColor: Colors.white,
                    buttonColor: Colors.green[900],
                    width: MediaQuery.of(context).size.width * .2,
                    labelSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final controller = Provider.of<SafraController>(context);
    //print(controller.safras.length);
    print('build select safra dialog');
    //print(safras);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
