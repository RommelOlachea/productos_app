import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  //_firebaseToken, es el token de firebase para acccesar a si API
  final String _firebaseToken = 'AIzaSyAIpNTWAcemkhEr3c-ou_Wq_pwWLNUMq9o';

  final storage = new FlutterSecureStorage(); //instancia del secure storage

  Future<String?> createUser(String email, String password) async {
    //Creamos el mapa que se enviara como data en el metodo post
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    //el mapa que contiene el key, es el argumento enviado, este caso el apikey token
    //si retornamos algo es un error
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('idToken')) {
      // grabamos el token en un lugar seguro
      await storage.write(key: 'token', value: decodeResp['idToken']);
      //return decodeResp['idToken'];
      return null;
    } else {
      //regresamos el error de la respuesta
      return decodeResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    //Creamos el mapa que se enviara como data en el metodo post
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    //el mapa que contiene el key, es el argumento enviado, este caso el apikey token
    //si retornamos algo es un error
    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('idToken')) {
      // grabamos el token en un lugar seguro
      await storage.write(key: 'token', value: decodeResp['idToken']);
      //return decodeResp['idToken'];
      return null;
    } else {
      //regresamos el error de la respuesta
      return decodeResp['error']['message'];
    }
  }

  Future logOut() async {
    await storage.delete(key: 'token');

    return;
  }

  //tratamos de leer el token, si no lo encontramos regresamos vacio
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}

/*liga con la documentacion sobre la autenticacion con email y password en firebase
https://firebase.google.com/docs/reference/rest/auth?hl=es-419#section-sign-in-email-password
configuracion en el ep. 247

La parte de la documentacion que se utiliza es solamente es Registrese con correo electronico
y contrasena, y la de Iniciar sesion con correo electronico y contrasena 

Nota: con el idToken guardado, podemos preguntarle al backend si ese idToken guardado es 
valido para continuar con el usuario, es decir con su sesion por asi decirlo.



*/
