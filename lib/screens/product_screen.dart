import 'package:flutter/material.dart';
import 'package:productos_app/widgets/product_image.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = 'product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*Nota: utlizamos el SingleChildScrollView para asegurarnos de que se
pueda hacer scroll si el teclado o algun otro elemento tapa o no alcanza
a desplegarse en la pantalla */