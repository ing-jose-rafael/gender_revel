import 'package:flutter/material.dart';
import 'package:gender_reveal/providers/auth_provider.dart';
import 'package:gender_reveal/providers/login_form_provider.dart';
import 'package:gender_reveal/providers/socket_provider.dart';
import 'package:gender_reveal/router/router.dart';
import 'package:gender_reveal/ui/buttons/custom_outlined_button.dart';
import 'package:gender_reveal/ui/buttons/link_text.dart';
import 'package:gender_reveal/ui/inputs/custom_inputs.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(
        builder: (BuildContext context) {
          final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);
          return Container(
            // color: Colors.pink,
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              /** ConstrainedBox limitando el tamaño del formulario maximo 370, menos de eso se adaptará  */
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 370),
                /** formulario manejado con un gestor de estado independiente, 
           * por eso usuamos key: loginProvider.formKey,  */
                child: Form(
                  autovalidateMode: AutovalidateMode.always, // para ir validando en tiempo real
                  key: loginFormProvider.formKey,
                  child: Column(
                    children: [
                      /** Email */
                      TextFormField(
                        onFieldSubmitted: (_) => onFormSubmit(
                            loginFormProvider, authProvider, socketProvider), // para que funcione con el enter
                        onChanged: (value) => loginFormProvider.phone = int.parse(value.trim()),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Ingrese el numero de telefono';
                          // if (!EmailValidator.validate(email ?? '')) return 'El Email no es válido';
                          return null; // campo válido
                        },
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.phone,
                        decoration: CustomInput.authInputDecoration(
                          hint: 'Ingrese número celular',
                          label: 'Celular',
                          icon: Icons.phone_outlined,
                        ),
                      ),
                      SizedBox(height: 20),
                      /** Contraseña */
                      TextFormField(
                        onFieldSubmitted: (_) => onFormSubmit(loginFormProvider, authProvider, socketProvider),
                        onChanged: (value) => loginFormProvider.password = value.trim(),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Ingrese contraseña';
                          if (value.length < 6) return 'La contraseña debe ser mayor a 6 caracteres';
                          return null; // valido
                        },
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: CustomInput.authInputDecoration(
                          label: 'Contraseña',
                          hint: '***********',
                          icon: Icons.lock_outline_rounded,
                        ),
                      ),
                      SizedBox(height: 20),
                      // btn
                      CustomOutLinedButton(
                        text: 'Ingresar',
                        // onPressed: () {
                        //   final isValid = loginProvider.validateForm();
                        //   if (isValid) {
                        //     authProvider.login(loginProvider.email, loginProvider.password);
                        //   }
                        // },
                        onPressed: () => onFormSubmit(loginFormProvider, authProvider, socketProvider),
                      ),
                      SizedBox(height: 20),
                      // link de registro
                      LinkText(
                        text: 'Nueva cuenta',
                        onPressed: () {
                          // Hacer que mavegue a otra vista
                          Navigator.pushReplacementNamed(context, Flurorouter.registerRoute);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onFormSubmit(LoginFormProvider loginFormProvider, AuthProvider authProvider, SocketProvider socketProvider) {
    final isValid = loginFormProvider.validateForm();
    if (isValid) {
      authProvider.login(loginFormProvider.phone, loginFormProvider.password);
    }
  }
}
