import 'package:flutter/material.dart';

class SplashLayout extends StatelessWidget {
  final String titulo;

  const SplashLayout({Key? key, this.titulo = 'Cheking...'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(titulo),
          ],
        ),
      ),
    );
  }
}
