import 'package:flutter/material.dart';
import 'package:meu_campo/app/modules/auth/view/register_page.dart';
import 'package:meu_campo/app/modules/home/view/home_page.dart';
import 'package:meu_campo/app/modules/noticias/view/noticias_page.dart';
import 'package:meu_campo/app/modules/splash/view/splash_page.dart';
import 'app/modules/auth/view/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Campo',
      theme: ThemeData(primaryColor: Colors.green, primarySwatch: Colors.green),
      initialRoute: SplashPage.router,
      routes: {
        SplashPage.router: (_) => SplashPage(),
        HomePage.router: (_) => HomePage(),
        LoginPage.router: (_) => LoginPage(),
        RegisterPage.router: (_) => RegisterPage(),
        NoticiasPage.router: (_) => NoticiasPage(),
      },
    );
  }
}
