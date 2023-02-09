import 'package:flutter/material.dart';
import 'package:productos_app/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Productos')),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => ProductCard()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
