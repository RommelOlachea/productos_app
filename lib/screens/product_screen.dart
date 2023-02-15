import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/product_image.dart';

import '../ui/input_decoration.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = 'product';

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );

    /* al extraer en el body del screenproduct, podemos crear
    el product form provider y en el child tener ProductScreenBody para 
    que de esta manera elebar el productformprovider al nivel mas alto 
    y puede ser accedido dentro de todos su widgets, se declaro de una 
    forma similar que en el login, notese que se creo como parametro del 
    del _ProductScreenBody el productService y se lo paso al extraerlo, 
    y el unico motivo por el que hacemos esto, es porque el boton de la 
    camara esta fuera del widget de donde se creo el Form */
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productService,
  });

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productService.selectedProduct.picture,
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  top: 60,
                  left: 20,
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () async {
                      //TODO: Camara o galeria
                      final picker = new ImagePicker();
                      final PickedFile? pickedFile = await picker.getImage(
                          source: ImageSource.gallery,
                          //source: ImageSource.camera,
                          imageQuality: 100);
                      //el parametro source me permite seleccionar, entre la camara o
                      //la galeria

                      if (pickedFile == null) {
                        print('No seleccionamos nada');
                        return;
                      } else {
                        print('Tenemos imagen ${pickedFile.path}');
                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      }
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  top: 60,
                  right: 20,
                ),
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt_outlined),
        onPressed: () async {
          if (!productForm.isValidForm()) return;

          await productService.saveOrCreateProduct(productForm.product);
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'El nombre es obligatorio';
                    }
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del producto', labelText: 'Nombre:'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: '${product.price}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.price = 0;
                    } else {
                      product.price = double.parse(value);
                    }
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '\$150', labelText: 'Precio:'),
                ),
                SizedBox(
                  height: 30,
                ),
                SwitchListTile.adaptive(
                    value: product.available,
                    title: Text('Disponible'),
                    activeColor: Colors.indigo,
                    onChanged: (value) =>
                        productForm.updateAvailability(value)),
                SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5,
            )
          ]);
}

/*Nota: utlizamos el SingleChildScrollView para asegurarnos de que se
pueda hacer scroll si el teclado o algun otro elemento tapa o no alcanza
a desplegarse en la pantalla */

/*inputFormatters , nos permite poner diferentes reglas para darle 
formato al valor del campo */

/*si queremos que el teclado se oculte cuando hacemos scroll en el 
formulario, utilizamos la propiedad del scrollviewchild 
keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, para 
que se oculte con el scroll, pero esto es a consideracion cuando sea practico */
