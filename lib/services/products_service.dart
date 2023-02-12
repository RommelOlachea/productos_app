import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-77384-default-rtdb.firebaseio.com';

  final List<Product> productos = [];
  late Product selectedProduct;

  bool isLoading = true;

  ProductsService() {
    this.loadProducts();
  }

  Future loadProducts() async {
    this.isLoading = true; /*indicamos que inicio la carga de Prod*/
    notifyListeners();

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

    this.isLoading = false; /*Indicamos que finalizo la carga de prod*/
    notifyListeners();
    // print(this.productos[0].name);
  }

  //TODO: Hacer fetch de productos
}


/*El servicio es el que se va a encargar de hacer las peticiones http
quien va a traer los post por nosotros */

/*con la palabra reservada late, le indicamos al dart que el objeto 
cuando sea utilizadao si contendra un valor*/

/*Recordemos tambien que en dart, todos los objetos se pasan por 
referencia, es decir, la referencia modifica al objeto en si, por
lo que si asiganmos un producto de la lista de productos a una variable
y modificamos la variable, en realidad estaremos modificando el contenido
de la lista de productos */