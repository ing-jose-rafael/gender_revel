import 'package:flutter/material.dart';

class CustomOutLinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final bool isFilled;
  final bool isTextWhite;
  const CustomOutLinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.isFilled = false,
    this.isTextWhite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          this.text,
          style: TextStyle(fontSize: 16, color: isTextWhite ? Colors.white : color),
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        side: MaterialStateProperty.all(BorderSide(color: color)),
        backgroundColor: MaterialStateProperty.all(isFilled ? color.withOpacity(0.3) : Colors.transparent),
      ),
    );
  }
}
