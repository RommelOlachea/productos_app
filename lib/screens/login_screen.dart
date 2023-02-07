import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'Login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _LoginForm(),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Crear nueva cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      )),
    );
  }
}

/* El SingleChildScrollView me permite hacer scroll en la pantalla
si los hijos sobrepasan el tamaño permitido de la pantalla */

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          //TODO: mantener la referencia al KEY
          child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                hintText: 'John.doe@gmail.com',
                labelText: 'Correo Electronico',
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.alternate_email_sharp,
                  color: Colors.deepPurple,
                )),
          ),
        ],
      )),
    );
  }
}