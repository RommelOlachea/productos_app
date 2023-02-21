import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-77384-default-rtdb.firebaseio.com';

  final List<Product> products = [];
  late Product selectedProduct;

  final storage = new FlutterSecureStorage();

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    this.loadProducts();
  }

  Future loadProducts() async {
    this.isLoading = true; /*indicamos que inicio la carga de Prod*/
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach(
      (key, value) {
        final tempProduct = Product.fromMap(value);
        tempProduct.id = key;
        this.products.add(tempProduct);
      },
    );

    this.isLoading = false; /*Indicamos que finalizo la carga de prod*/
    notifyListeners();
    // print(this.productos[0].name);
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //Es necesario crear el producto
      await createProduct(product);
    } else {
      //actualizamos el producto
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    /*Para llegar al nodo del producto a actualizar debemos
    agregar el id del nodo en el segmento */
    final url = Uri.https(_baseUrl, 'products/${product.id}.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    print(decodedData);
    //TODO: Actualizar la lista de productos
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp =
        await http.post(url, body: product.toJson()); //metodo post para agregar
    final decodedData =
        json.decode(resp.body); //pasamos el json string a un mapa
    /*nota en el decodeData en la propiedad name, tenemos el id, regresado
    por firebase*/
    product.id = decodedData['name'];
    products.add(product);

    return product.id!;
  }

  /*con este metodo cargamos la imagen seleccionada, ya sea de la galeria
  o de la camara, en el producto seleccionado, pero todavia no la guardamos 
  en la nube, solo me sirve para mostrasrla en el ProductScreen*/
  void updateSelectedProductImage(String path) {
    this.selectedProduct.picture = path;
    //este tiene el archivo con la imagen, para subirla a Cloudinary
    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) {
      return null;
    }

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dfpteejk3/image/upload?upload_preset=wanwuerd');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;

    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }
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
