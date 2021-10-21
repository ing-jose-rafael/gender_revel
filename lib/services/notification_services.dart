import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackBarError(String mensaje) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(mensaje, style: TextStyle(color: Colors.white)),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackBarOk(String mensaje) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green.withOpacity(0.9),
      content: Text(mensaje, style: TextStyle(color: Colors.white)),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  // para lanzar un modal indicador
  static showBusyIndicator(BuildContext buildcontext) {
    final AlertDialog dialog = AlertDialog(
      content: Container(
        width: 100,
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
    );

    showDialog(context: buildcontext, builder: (_) => dialog);
  }
}
