import 'package:flutter/material.dart';

class RegitserFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // campos que tiene el formulario de entrada
  String nombre = '', password = '';
  int phone = 000000000;

  // validateForm() {
  //   if (formKey.currentState!.validate()) {
  //     print('Form válido');
  //     print('$nombre == $correo == $password');
  //   } else {
  //     print('Form not válido');
  //   }
  // }
  bool validateForm() => formKey.currentState!.validate() ? true : false;
}
