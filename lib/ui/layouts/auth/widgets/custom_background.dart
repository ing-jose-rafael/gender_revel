import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // para que se estire la imagen
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: BoxConstraints(maxWidth: 400), //limitando el tamaño
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            // child: Image(
            //   image: AssetImage('assets/logo.png'),
            //   width: 400,
            // ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
      );
}
