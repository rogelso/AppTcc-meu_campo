import 'package:flutter/material.dart';
import 'package:meu_campo/app/modules/auth/controllers/register_controller.dart';

import 'package:meu_campo/app/shared/mixins/loader_mixin.dart';
import 'package:meu_campo/app/shared/mixins/messages_mixin.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticiasPage extends StatelessWidget {
  static const router = '/noticias';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notícias e Cotações Agrícolas'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ChangeNotifierProvider(
            create: (context) => RegisterController(),
            child: NoticiasContent(),
          ),
        ),
      ),
    );
  }
}

class NoticiasContent extends StatefulWidget {
  @override
  _NoticiasContentState createState() => _NoticiasContentState();
}

class _NoticiasContentState extends State<NoticiasContent>
    with LoaderMixin, MessagesMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * .95,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              onPressed: () {
                abrirUrlNoticiasAgricolas();
              },
              elevation: 2.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
              color: Colors.lightBlue,
              icon: Icon(Icons.new_releases),
              label: Text(
                "Visualizar Notícias Agrícolas",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              onPressed: () {
                abrirUrlCotacoesAgricolasSoja();
              },
              elevation: 2.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
              color: Colors.orange,
              icon: Icon(Icons.attach_money),
              label: Text(
                "Visualizar Cotações - SOJA",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton.icon(
              onPressed: () {
                abrirUrlCotacoesAgricolasMilho();
              },
              elevation: 2.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
              color: Colors.yellowAccent,
              icon: Icon(Icons.attach_money),
              label: Text(
                "Visualizar Cotações - MILHO",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

abrirUrlNoticiasAgricolas() async {
  const url = 'https://www.noticiasagricolas.com.br/noticias/agronegocio/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

abrirUrlCotacoesAgricolasSoja() async {
  const url = 'https://www.noticiasagricolas.com.br/cotacoes/soja';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

abrirUrlCotacoesAgricolasMilho() async {
  const url = 'https://www.noticiasagricolas.com.br/cotacoes/milho';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
