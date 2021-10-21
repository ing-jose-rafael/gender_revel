import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gender_reveal/ui/layouts/auth/widgets/custom_background.dart';
import 'package:gender_reveal/ui/layouts/auth/widgets/custom_title.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            /** de manera condicional redibujamos el widget correspondiente */
            (size.width > 1000)
                ?
                // Desktop
                _DesktopBoy(child: child)
                :
                // Mobiel
                _MobileBody(child: child),
            // puede poner pie pagina
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     child: child,
    //   ),
    // );
  }
}

class _DesktopBoy extends StatelessWidget {
  const _DesktopBoy({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      /** dimensiones controladas para evitar que el contenido 
       * se pase y no tener que hacer scroll */
      width: size.width,
      height: size.height * 0.95, //
      child: Row(
        children: [
          Expanded(child: CustomBackground()),
          Container(
            width: 600.0,
            height: double.infinity,
            // color: Colors.black,
            child: Stack(
              children: [
                Positioned(bottom: -720, child: SvgPicture.asset('assets/bg-1-left.svg')),
                Positioned(bottom: -720, child: SvgPicture.asset('assets/bg-1-right.svg')),
                Column(
                  children: [
                    SizedBox(height: 20),
                    CustomTile(),
                    // SizedBox(height: 30),
                    /** Tomando el espacio retante para dibujar la vista */
                    Expanded(child: child),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          CustomTile(),
          /** Espacio para el child */

          Container(
            height: 400,
            width: double.infinity,
            // color: Colors.pink,
            child: Stack(
              children: [
                if (size.width < 370) ...[
                  Positioned(bottom: -560, left: 0, right: -10, child: SvgPicture.asset('assets/bg-1-left.svg')),
                  Positioned(
                      bottom: -10,
                      right: -40,
                      left: 240,
                      child: SvgPicture.asset(
                        'assets/bg-1-right.svg',
                        height: 100,
                        width: 200,
                      )),
                ],
                if (size.width > 370) ...[
                  Positioned(bottom: -740, left: -210, right: -140, child: SvgPicture.asset('assets/bg-1-left.svg')),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        'assets/bg-1-right.svg',
                        height: 190,
                      )),
                ],
                child,
              ],
            ),
          ),
          Container(
            height: 400,
            width: double.infinity,
            child: CustomBackground(),
          ),
        ],
      ),
    );
  }
}
