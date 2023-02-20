import 'package:flutter/material.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:productos_app/screens/login_screen.dart';
import 'package:productos_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  static final String routName = 'checking';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToken(),
            builder: ((BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return Text('Espere');
              }

              //Nota: el Future.microtask se ejecuta inmediantamente despues de que la construccion
              //del widget (CheckAuthScreen) termine, si mandaramos llamar directamente
              //el Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);  la
              //aplicacion marcaria un error
              Future.microtask(() {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              });

              return Container();
            })),
      ),
    );
  }
}
