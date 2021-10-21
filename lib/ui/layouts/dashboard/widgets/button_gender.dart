import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBtnTeam extends StatelessWidget {
  const CustomBtnTeam({
    Key? key,
    required this.img,
    required this.imgGender,
    required this.generel,
    required this.color,
    required this.onPressed,
  }) : super(key: key);
  final String img;
  final String imgGender;
  final String generel;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 180,
      // color: Colors.red,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onPressed(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                  // margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  // height: 190,
                  decoration: buildBoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SizedBox(height: 10),
                      Image.asset(img),
                      SizedBox(height: 3),
                      FittedBox(
                        child: Text('Team', style: GoogleFonts.roboto(fontSize: 15)),
                      ),
                      FittedBox(
                        child: Text(generel, style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: color,
                  // backgroundImage: AssetImage('assets/icons8-mujer-48.png'),
                  child: Image.asset(imgGender, height: 20, width: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          // BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
          BoxShadow(color: Colors.grey[500]!, offset: Offset(5.0, 5.0), blurRadius: 15, spreadRadius: 1.0),
          BoxShadow(color: Colors.white, offset: Offset(-5.0, -5.0), blurRadius: 15, spreadRadius: 1.0),
        ],
      );
}
