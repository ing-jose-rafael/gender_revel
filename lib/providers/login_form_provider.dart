import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>(); // para manejar las validaciones del formulario
  int phone = 0;
  String password = '';
  /** 
   * Inyectando una depenencia opc 1
  ** 
  ** final AuthProvider authProvider;
  ** 
  ** LoginFormProvider(this.authProvider);
  ** 
  ** validateForm() {
  **   if (formKey.currentState!.validate()) {
  **     print('form valido');
  **     print('$email === $password');
  **     authProvider.login(email, password);
  **   } else {
  **     print('form no valido');
  **   }
  ** }
  **************/
  /// validateForm retorna un true o false
  bool validateForm() => (formKey.currentState!.validate()) ? true : false;
}
