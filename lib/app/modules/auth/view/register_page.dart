import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:meu_campo/app/modules/auth/controllers/register_controller.dart';
import 'package:meu_campo/app/shared/components/pizza_delivery_button.dart';
import 'package:meu_campo/app/shared/components/pizza_delivery_input.dart';
import 'package:meu_campo/app/shared/mixins/loader_mixin.dart';
import 'package:meu_campo/app/shared/mixins/messages_mixin.dart';

import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class RegisterPage extends StatelessWidget {
  static const router = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Criar Conta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ChangeNotifierProvider(
            create: (context) => RegisterController(),
            child: RegisterContent(),
          ),
        ),
      ),
    );
  }
}

class RegisterContent extends StatefulWidget {
  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent>
    with LoaderMixin, MessagesMixin {
  final formKey = GlobalKey<FormState>();
  final obscureTextPassword = ValueNotifier<bool>(true);
  final obscureTextConfirmPassword = ValueNotifier<bool>(true);
  final nameEditingController = TextEditingController();
  final sobrenomeEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final cidadeEditingController = TextEditingController();
  final ufEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = context.read<RegisterController>();
    controller.addListener(() {
      showHideLoaderHelper(context, controller.loading);

      if (!isNull(controller.error)) {
        showError(message: controller.error, context: context);
      }

      if (controller.registerSuccess) {
        showSuccess(
            message: 'Usuário Cadastrado com Sucesso', context: context);
        Future.delayed(Duration(seconds: 2), () => Navigator.of(context).pop());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/logoprincipal.png',
          width: 150,
        ),
        Container(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text('Cadastre-se',
                  //       style: TextStyle(
                  //           fontSize: 18, fontWeight: FontWeight.bold)),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  PizzaDeliveryInput(
                    'Nome',
                    controller: nameEditingController,
                    icon: Icon(FontAwesome.user),
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Nome obrigatório';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PizzaDeliveryInput(
                    'Sobrenome',
                    controller: sobrenomeEditingController,
                    icon: Icon(FontAwesome.user),
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Sobrenome obrigatório';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PizzaDeliveryInput(
                    'E-mail',
                    controller: emailEditingController,
                    icon: Icon(Icons.alternate_email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!isEmail(value?.toString() ?? '')) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: PizzaDeliveryInput(
                          'Cidade',
                          controller: cidadeEditingController,
                          icon: Icon(Icons.location_city),
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Cidade obrigatória';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: PizzaDeliveryInput(
                          'UF',
                          controller: ufEditingController,
                          //icon: Icon(Icons.c),
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'UF obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: obscureTextPassword,
                    builder: (_, obscureTextPasswordValue, child) {
                      return PizzaDeliveryInput(
                        'Senha',
                        controller: passwordEditingController,
                        icon: Icon(Icons.security),
                        suffixIcon: Icon(FontAwesome.lock),
                        obscureText: obscureTextPasswordValue,
                        suffixIconOnPressed: () {
                          obscureTextPassword.value = !obscureTextPasswordValue;
                        },
                        validator: (value) {
                          if (!isLength(value.toString(), 6)) {
                            return 'Senha precisa ter pelo menos 6 caracteres';
                          }

                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: obscureTextConfirmPassword,
                    builder: (_, obscureTextConfirmPasswordValue, child) {
                      return PizzaDeliveryInput(
                        'Confirmar Senha',
                        controller: confirmPasswordEditingController,
                        icon: Icon(Icons.security),
                        suffixIcon: Icon(FontAwesome.lock),
                        obscureText: obscureTextConfirmPasswordValue,
                        suffixIconOnPressed: () {
                          obscureTextConfirmPassword.value =
                              !obscureTextConfirmPasswordValue;
                        },
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Confirma senha obrigatória';
                          } else if (passwordEditingController.text !=
                              value.toString()) {
                            return 'Senha e Confirma senha não conferem';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PizzaDeliveryButton(
                    'CRIAR CONTA',
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        context.read<RegisterController>().registerUser(
                            nameEditingController.text,
                            sobrenomeEditingController.text,
                            emailEditingController.text,
                            passwordEditingController.text,
                            cidadeEditingController.text,
                            ufEditingController.text);
                      }
                    },
                    height: 50,
                    labelColor: Colors.white,
                    buttonColor: Theme.of(context).primaryColor,
                    width: MediaQuery.of(context).size.width * .95,
                    labelSize: 18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PizzaDeliveryButton(
                    'Voltar',
                    onPressed: () => Navigator.of(context).pop(),
                    height: 50,
                    labelSize: 18,
                    labelColor: Colors.black,
                    width: MediaQuery.of(context).size.width * .95,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
