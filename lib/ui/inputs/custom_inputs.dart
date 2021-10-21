import 'package:flutter/material.dart';

//
/// Clase con propiedades estaticas
///
/// requiere los siguientes parametros String hint, String label, IconData icon,
class CustomInput {
  static InputDecoration authInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) =>
      InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
      );

  /// Decoracion del Input buscar
  static InputDecoration searchInputDecoration({
    required String hint,
    required IconData icon,
  }) =>
      InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey),
      );
  static InputDecoration formInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) =>
      InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3))),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
      );
}
