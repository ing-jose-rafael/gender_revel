import 'package:flutter/material.dart';
import 'package:gender_reveal/providers/auth_provider.dart';
import 'package:gender_reveal/providers/register_form_provider.dart';
import 'package:gender_reveal/router/router.dart';
import 'package:gender_reveal/ui/buttons/custom_outlined_button.dart';
import 'package:gender_reveal/ui/buttons/link_text.dart';
import 'package:gender_reveal/ui/inputs/custom_inputs.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegitserFormProvider(),
      child: Builder(
        builder: (BuildContext context) {
          final registerFormProvider = Provider.of<RegitserFormProvider>(context, listen: false);
          return Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 370),
                child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: registerFormProvider.formKey,
                    child: Column(
                      children: [
                        /** Nombre */
                        TextFormField(
                          onChanged: (value) => registerFormProvider.nombre = value.trim(),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'El nombre es obligatorio';
                            if (value.length < 3) return 'El nombre debe ser mayor de 3 caracteres';
                            return null;
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: CustomInput.authInputDecoration(
                            hint: 'Ingrese su nombre',
                            label: 'Nombre',
                            icon: Icons.supervised_user_circle_sharp,
                          ),
                        ),
                        SizedBox(height: 20),
                        /** cellular */
                        TextFormField(
                          onChanged: (value) => registerFormProvider.phone = int.parse(value.trim()),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'El número de celular es obligatorio';
                            if (value.length < 9) return 'El numero debe ser mayor de 10 caracteres';
                            // if (!EmailValidator.validate(value ?? 'xx')) return 'Email no válido';
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          decoration: CustomInput.authInputDecoration(
                            hint: 'Ingrese número celular',
                            label: 'Celular',
                            icon: Icons.phone_outlined,
                          ),
                        ),
                        SizedBox(height: 20),
                        /** contraseña */
                        TextFormField(
                          onChanged: (value) => registerFormProvider.password = value.trim(),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'La contraseña es obligatorio';
                            if (value.length < 6) return 'El contraseña debe ser mayor de 6 caracteres';
                            return null;
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
                          text: 'Crear Cuenta',
                          onPressed: () {
                            final isValid = registerFormProvider.validateForm();
                            if (!isValid) return;
                            // print(
                            //   registerFormProvider.correo + registerFormProvider.password,
                            // );
                            // todo esta bien para mandar a guardar en la DB
                            Provider.of<AuthProvider>(context, listen: false).register(
                                registerFormProvider.phone, registerFormProvider.password, registerFormProvider.nombre);
                          },
                        ),
                        SizedBox(height: 20),
                        LinkText(
                          text: 'Ir a Login',
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, Flurorouter.loginRoute);
                          },
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
