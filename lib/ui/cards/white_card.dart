import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhitrCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final String? title;
  const WhitrCard({Key? key, required this.child, this.title, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      // decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            // FittedBox(
            //   child: Text(
            //     title!,
            //     style: GoogleFonts.roboto(
            //         fontSize: 15,
            //         fontWeight: FontWeight.bold,
            //         foreground: Paint()
            //           ..shader = LinearGradient(
            //             colors: [
            //               Color(int.parse('0xff5CA5D1')),
            //               Color(int.parse('0xffE8A7BE')),
            //               // Color(0xFF8e2de2),
            //               // Color(0xFF4a00e0),
            //             ],
            //           ).createShader(
            //             Rect.fromLTWH(0, 0, 400, 200),
            //           )),
            //   ),
            // ),
            FittedBox(
              child: ShaderMask(
                child: Text(
                  title!,
                  style: GoogleFonts.montserratAlternates(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shaderCallback: (rect) {
                  return LinearGradient(
                    stops: [0.3, 0.55],
                    colors: [
                      Color(int.parse('0xff5CA5D1')),
                      Color(int.parse('0xffE8A7BE')),
                    ],
                  ).createShader(rect);
                },
              ),
            ),
            Divider(),
          ],
          child,
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        // boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      );
}
