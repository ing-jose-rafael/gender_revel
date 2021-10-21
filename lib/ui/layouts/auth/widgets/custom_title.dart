import 'package:flutter/material.dart';
import 'package:gender_reveal/router/router.dart';
import 'package:gender_reveal/services/navigation_services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTile extends StatelessWidget {
  final double heightImg, fontSize;
  final bool alignmentCenter;
  const CustomTile({Key? key, this.fontSize = 60.0, this.heightImg = 100.0, this.alignmentCenter = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: (alignmentCenter) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/logo.png',
            // width: 100.0,
            height: heightImg,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: (alignmentCenter) ? 20 : 5),
          // FittedBox para que se adapte
          FittedBox(
            child: ShaderMask(
              child: Text(
                'Niño o Niña ?',
                style: GoogleFonts.montserratAlternates(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              shaderCallback: (rect) {
                return LinearGradient(
                  stops: [0.4, 0.6],
                  colors: [
                    Color(int.parse('0xff5CA5D1')),
                    Color(int.parse('0xffE8A7BE')),
                  ],
                ).createShader(rect);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTile2 extends StatelessWidget {
  final double heightImg, fontSize;
  final bool alignmentCenter;
  final String title;
  final Function onPressed;
  final bool mostarResultUser;
  const CustomTile2(
      {Key? key,
      this.fontSize = 60.0,
      this.heightImg = 100.0,
      this.alignmentCenter = true,
      required this.title,
      required this.onPressed,
      this.mostarResultUser = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        // crossAxisAlignment: (alignmentCenter) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/logo.png',
            // width: 100.0,
            height: heightImg,
            fit: BoxFit.fitWidth,
          ),
          // SizedBox(height: (alignmentCenter) ? 20 : 5),
          SizedBox(width: 5),
          // FittedBox para que se adapte
          Expanded(
            child: FittedBox(
              child: ShaderMask(
                child: Text(
                  title,
                  style: GoogleFonts.montserratAlternates(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shaderCallback: (rect) {
                  return LinearGradient(
                    stops: [0.4, 0.6],
                    colors: [
                      Color(int.parse('0xff5CA5D1')),
                      Color(int.parse('0xffE8A7BE')),
                    ],
                  ).createShader(rect);
                },
              ),
            ),
          ),
          if (mostarResultUser)
            Container(
              //width: 40,
              padding: EdgeInsets.only(left: 5),

              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () => NavigationService.navigatorTo(Flurorouter.dashboardRouteResult),
                      child: Icon(Icons.dashboard_outlined, color: Colors.black.withOpacity(0.3)))),
            ),
          Container(
            //width: 40,
            padding: EdgeInsets.only(left: 10),

            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () => onPressed(),
                    child: Icon(Icons.exit_to_app_outlined, color: Colors.black.withOpacity(0.3)))),
          ),
        ],
      ),
    );
  }
}
