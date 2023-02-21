import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/ui/input_decoration.dart';
import 'package:productos_app/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register';
  const RegisterScreen({Key? key}) : super(key: key);

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
                    'Crear cuenta',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () => Navigator.pushReplacementNamed(
                    context, LoginScreen.routeName),
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                child: const Text(
                  '¿Ya tienes una cuenta?',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                )),
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
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          //mantener la referencia al KEY
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'john.doe@gmail.com',
                    labelText: 'Correo Electronico',
                    prefixIcon: Icons.alternate_email_rounded),
                onChanged: (value) => loginForm.email = value,
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
                onChanged: (value) => loginForm.password = value,
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
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          //si instanciamos en un metodo, es una buena practica que el listen este en false;
                          final authService =
                              Provider.of<AuthService>(context, listen: false);
                          if (!loginForm.isValidForm()) return;

                          loginForm.isLoading = true;

                          // await Future.delayed(const Duration(seconds: 2));
                          final String? errorMessage = await authService
                              .createUser(loginForm.email, loginForm.password);

                          if (errorMessage == null) {
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
                          } else {
                            //TODO: mostrar error en pantalla
                            print(errorMessage);
                            loginForm.isLoading = false;
                          }
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere' : 'Ingresar',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ))
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

/* la propiedad key es una referencia al widgets en si*/

/*El ChangeNotifierProvider es igual al multiprovider, pero lo utilizamos solamente cuando tenemos uno, o 
queremos usar uno solamente, en este ejemplo lo usamos no en el main como anteriormente */
/*Por default en esta declaracion esta en modo lazy, y se le declara como child  el _LoginForm, lo cual me permite redibujar
los widgets cuando sea necesario, y solo va a vivir en el scope de _LoginForm, es decir solo los widgets que estan dentro de 
_LoginForm tendran el acceso al LoginFormProvider   */

/* el Navigator.pushReplacementName va a destruir el stack de las pantallas y no podremos regresar aunque quisieramos
regularmente se utiliza para las pantallas de login cuando ya se autentica*/

/*FocusScope.of(context).unfocus() con esta instruccion quitamos el teclado
de la pantalla cuando presionamos el boton de ingresar */

/*loginForm.isLoading en este set del LoginFormProvider lanzamos el metodo 
notifyListeners(); para que se redibujen los widgets */
