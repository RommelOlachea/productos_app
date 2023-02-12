import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/products_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

/*Creamos el provider del ProducsService de manera global
al inicio del arbol de widgets */
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductsService())],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: HomeScreen.routeName,
        routes: {
          LoginScreen.routeName: (_) => LoginScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
          ProductScreen.routeName: (_) => ProductScreen(),
        },
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.grey[300],
            appBarTheme: const AppBarTheme(
              elevation: 0,
              color: Colors.indigo,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                elevation: 0, backgroundColor: Colors.indigo)));
  }
}
