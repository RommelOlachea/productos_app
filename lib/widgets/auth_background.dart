import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          this.child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

/*Con double.infinity le estamos diciendo al contenedor que ocupe
el ancho y el alto de la pantallad el dispositivo */

/*El Widget SafeArea nos permite asegurarnos que el widgets que este
contenido en el, no tocara el notch del dispositivo en caso de 
tenerlo */

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
