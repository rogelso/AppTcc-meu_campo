import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:meu_campo/app/modules/auth/controllers/login_controller.dart';
import 'package:meu_campo/app/modules/auth/view/register_page.dart';
import 'package:meu_campo/app/modules/home/view/home_page.dart';
import 'package:meu_campo/app/modules/splash/view/splash_page.dart';
import 'package:meu_campo/app/shared/components/meu_campo_button.dart';
import 'package:meu_campo/app/shared/components/meu_campo_input.dart';
import 'package:meu_campo/app/shared/mixins/loader_mixin.dart';
import 'package:meu_campo/app/shared/mixins/messages_mixin.dart';

import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatelessWidget {
  static const router = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ChangeNotifierProvider(
            create: (context) => LoginController(),
            child: LoginContent(),
          ),
        ),
      ),
    );
  }
}

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with LoaderMixin, MessagesMixin {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final obscurePasswordValueNotifier = ValueNotifier<bool>(true);
  final obscurePassword = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    final loginController = context.read<LoginController>();
    loginController.addListener(() {
      showHideLoaderHelper(context, loginController.showLoader);

      if (!isNull(loginController.error)) {
        showError(message: loginController.error, context: context);
      }

      if (loginController.loginSuccess) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.router, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Column(
      children: [
        Image.asset(
          'assets/images/logoprincipal.png',
          width: 250,
        ),
        Container(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MeuCampoInput(
                    'E-mail',
                    icon: Icon(Icons.alternate_email),
                    controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!isEmail(value?.toString() ?? '')) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: obscurePasswordValueNotifier,
                    builder: (_, obscurePasswordValueNotifierValue, child) {
                      return MeuCampoInput('Senha',
                          controller: passwordEditingController,
                          icon: Icon(Icons.security),
                          suffixIcon: Icon(FontAwesome.lock),
                          suffixIconOnPressed: () {
                            obscurePasswordValueNotifier.value =
                                !obscurePasswordValueNotifierValue;
                          },
                          obscureText: obscurePasswordValueNotifierValue,
                          validator: (value) {
                            if (!isLength(value.toString(), 8)) {
                              return 'Senha deve conter no mínimo 8 caracteres';
                            }
                            return null;
                          });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MeuCampoButton(
                    'Login',
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        context.read<LoginController>().login(
                              emailEditingController.text,
                              passwordEditingController.text,
                            );
                      }
                    },
                    height: 50,
                    labelColor: Colors.white,
                    buttonColor: Theme.of(context).primaryColor,
                    width: MediaQuery.of(context).size.width * .92,
                    labelSize: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 30,
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: FlatButton(
            onPressed: () {},
            child: Text(
              "Esqueceu sua Senha?",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 15.0, decoration: TextDecoration.underline),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 38,
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text('Não tem uma Conta?',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 40,
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterPage.router);
                    },
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF616161),
                            Color(0xFF616161),
                            Color(0xFF616161),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('  Criar Conta  ',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
