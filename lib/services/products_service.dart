import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-77384-default-rtdb.firebaseio.com';

  final List<Product> productos = [];

  //TODO: Hacer fetch de productos
}






/*El servicio es el que se va a encargar de hacer las peticiones http
quien va a traer los post por nosotros */