import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  //_firebaseToken, es el token de firebase para acccesar a si API
  final String _firebaseToken = 'AIzaSyAIpNTWAcemkhEr3c-ou_Wq_pwWLNUMq9o';

  Future<String?> createUser(String email, String password) async {
    //Creamos el mapa que se enviara como data en el metodo post
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    //el mapa que contiene el key, es el argumento enviado, este caso el apikey token
    //si retornamos algo es un error
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('idToken')) {
      // todo: grabar token en un lugar seguro
      //return decodeResp['idToken'];
      return null;
    } else {
      //regresamos el error de la respuesta
      return decodeResp['error']['message'];
    }
  }
}

/*liga con la documentacion sobre la autenticacion con email y password en firebase
https://firebase.google.com/docs/reference/rest/auth?hl=es-419#section-sign-in-email-password
configuracion en el ep. 247
*/
