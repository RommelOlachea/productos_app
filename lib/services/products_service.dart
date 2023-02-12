import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-77384-default-rtdb.firebaseio.com';

  final List<Product> productos = [];
  bool isLoading = true;

  ProductsService() {
    this.loadProducts();
  }

  Future loadProducts() async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach(
      (key, value) {
        final tempProduct = Product.fromMap(value);
        tempProduct.id = key;
        this.productos.add(tempProduct);
      },
    );

    print(this.productos[0].name);
  }

  //TODO: Hacer fetch de productos
}






/*El servicio es el que se va a encargar de hacer las peticiones http
quien va a traer los post por nosotros */