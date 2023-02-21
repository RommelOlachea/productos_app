import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    print('${email} - ${password}');
    return formKey.currentState?.validate() ?? false;
  }
}


/*En el metodo isValidForm regresamos true si es correcto el formulario y
false si es invalido, es decir, no paso alguna validacion*/

/*El FormState esta asociado a un widget de tipo Form, pero tambien podemos
tener un ScafoldState que este asociado a un Scafold, de tal manera que con
el GlobalKey podemos tener una referencia al widget en cuestion mediante su
propiedad key*/
