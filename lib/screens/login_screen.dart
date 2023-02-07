import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decoration.dart';
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
            ),
            const SizedBox(
              height: 50,
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'john.doe@gmail.com',
                    labelText: 'Correo Electronico',
                    prefixIcon: Icons.add_photo_alternate_rounded),
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Correo invalido';
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '*****',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_clock_outlined),
                validator: (value) {
                  if (value != null && value.length >= 6) return null;
                  return 'La contraseña debe ser de 6 caracteres';
                },
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    //TODO: login form
                  })
            ],
          )),
    );
  }
}

/* En el formulario cuando utilizamos el autovalidateMode: AutovalidateMode.onUserInteraction, nos indica que con cada
interaccion que se tenga con el input el usuario, se realizara la validacion del mismo*/

/* con el key del formulario nos daremos cuenta si todos los controles pasaron la validacion */

/* si la propiedad validator del TextFormField, regresa una cadena significa que no paso la validacion,
si regresa un null significa que si la paso */