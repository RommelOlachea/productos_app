import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    /*Preguntamos si esta en carga de articulos o finalizo*/
    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Productos')),
      ),
      body: ListView.builder(
          itemCount: productsService.productos.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ProductScreen.routeName),
              child: ProductCard(
                product: productsService.productos[index],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

/*Con el widget GestureDectector sabemos si se hizo el tap en el product card
para despues redireccionarlo a la pantalla de ProductScreen*/