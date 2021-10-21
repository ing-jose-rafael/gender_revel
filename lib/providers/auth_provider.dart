import 'package:flutter/material.dart';
import 'package:gender_reveal/api/gender_reveal_api.dart';
import 'package:gender_reveal/models/http/auth_response.dart';
import 'package:gender_reveal/models/usuario_model.dart';
import 'package:gender_reveal/router/router.dart';
import 'package:gender_reveal/services/local_storage.dart';
import 'package:gender_reveal/services/navigation_services.dart';
import 'package:gender_reveal/services/notification_services.dart';

// manteniendo el estado de la autentificacion

enum AuthStatus {
  cheking,
  authenticated,
  notAuthenticated,
}

/// Para manejar la informacion que usuario esta conectado,
/// permite en todo momento saber si el usuario esta autenticado
class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.cheking; // revisando el estado
  Usuario? user;
  late bool _autenticando;

  AuthProvider() {
    this.isAuthenticated();
  }

  /// Necesita el email y el passwoard
  login(int phone, String pass) {
    this.autenticando = true;

    final data = {
      'celular': phone,
      'password': pass,
    };
    // print(data);
    //péticion HTTPS
    GenderRevealApi.post('/auth/login', data).then((json) {
      //   // print(json);
      final authResponse = AuthResponse.fromMap(json);
      // print(authResponse);
      this.user = authResponse.usuario;
      this._token = authResponse.token;
      //Guardando en localStorage
      LocalStorage.prefs.setString('token', this._token!);
      authStatus = AuthStatus.authenticated; // cambiamos el estado
      NavigationService.replaceTo(Flurorouter.dashboardRoute); // cambio el URL
      GenderRevealApi.configuraDio(); // acualizando el token en la configuracion DIO
      this.autenticando = false;
      // notifyListeners();
      //   // cambiando de Layout
      //   NavigationService.replaceTo(Flurorouter.dashboardRoute); // cambiando el Url
    }).catchError((e) {
      // Mostar notificacion de error
      print(e);
      this.autenticando = false;
      NotificationsService.showSnackBarError('Usuario / Credenciales no válidos');
    });
    // this._token = 'jkaljsdklc_nd2379827';
    // print('Almacenar JWT: $_token');
    // LocalStorage.prefs.setString('token', this._token!);
    // authStatus = AuthStatus.authenticated; // cambiamos el estado
    // notifyListeners();
    //Navegar al dashboard
    // NavigationService.replaceTo(Flurorouter.dashboardRoute); // cambiando el Url
    // this.isAuthenticated();
    // cambiando de Layout
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      this.authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    //Ir al backend y validar el JWT
    try {
      // se hace la peticion
      final resp = await GenderRevealApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(resp);
      // se establecen propiedades en el Auth Provider
      this.user = authResponse.usuario;
      this._token = authResponse.token;
      // se notifica
      LocalStorage.prefs.setString('token', this._token!);
      authStatus = AuthStatus.authenticated; // cambiamos el estado
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated; // cambiamos el estado
      notifyListeners();
      return false;
    }
    // await Future.delayed(Duration(milliseconds: 1000));
    // this.authStatus = AuthStatus.authenticated;
    // notifyListeners();
    // return true;
  }

  /// Necesita el email y el passwoard
  register(int phone, String pass, String name) {
    // mapa con los dts que se tienen que enviar al backend
    this.autenticando = true;
    final data = {
      'nombre': name,
      'celular': phone,
      'password': pass,
    };

    GenderRevealApi.post('/usuarios', data).then((json) {
      // print(json);
      final authResponse = AuthResponse.fromMap(json);
      this.user = authResponse.usuario;
      this._token = authResponse.token;
      //Guardando en localStorage
      LocalStorage.prefs.setString('token', this._token!);
      authStatus = AuthStatus.authenticated; // cambiamos el estado
      // cambiando de Layout
      //Navegar al dashboard
      NavigationService.replaceTo(Flurorouter.dashboardRoute); // cambiando el Url
      GenderRevealApi.configuraDio(); // acualizando el token en la configuracion de Dio
      this.autenticando = false;
      // notifyListeners();
    }).catchError((e) {
      print('Error en $e');
      // Mostar notificacion de error
      this.autenticando = false;
      NotificationsService.showSnackBarError('Celular no es válido');
    });
    // this._token = 'sakjdkla.hjsdhkjahskd.wyuwhsbzcm';

    // // print('Almacenar JWT: $_token');
    // this.isAuthenticated();
  }

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  logout() {
    LocalStorage.prefs.remove('token'); // remover el token
    authStatus = AuthStatus.notAuthenticated; // cambiamos el estado
    notifyListeners();
  }
}
