import 'package:flutter/material.dart';

/// Para mmanejar la navegacion entre layout, tiene propiedades y metos estaiticos
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  ///Metodo que perimite navegar, es conveniente si la persona va regresar a la
  static navigatorTo(String routeName) {
    navigatorKey.currentState!.pushNamed(routeName);
  }

  ///Metodo que perimite navegar sin tener el historial de la página anterior
  /// ejemplo cuando pasamos del login a dashboard no queremos que regrese al login
  static replaceTo(String routeName) {
    navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
