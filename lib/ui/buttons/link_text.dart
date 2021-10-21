import 'package:flutter/material.dart';

// LinkText es un StatefulWidget por que tiene cambios cuando
// se pasa el mouse por encima
/// ´argumentos´
/// ** text
/// es
class LinkText extends StatefulWidget {
  final String text;
  final Function? onPressed;
  const LinkText({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  _LinkTextState createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) widget.onPressed!();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // pone el icon de la mano cuando esta sobre el child
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue.shade700,
              decoration: isHover ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
