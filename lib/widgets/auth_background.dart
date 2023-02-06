import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
        ],
      ),
    );
  }
}

/*Con double.infinity le estamos diciendo al contenedor que ocupe
el ancho y el alto de la pantallad el dispositivo */

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(
            child: _Buble(),
            top: 90,
            left: 30,
          ),
          Positioned(
            child: _Buble(),
            top: -40,
            left: -30,
          ),
          Positioned(
            child: _Buble(),
            top: -50,
            right: -20,
          ),
          Positioned(
            child: _Buble(),
            bottom: -50,
            left: 10,
          ),
          Positioned(
            child: _Buble(),
            bottom: 120,
            right: 20,
          ),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]));
}

class _Buble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
