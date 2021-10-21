import 'package:dio/dio.dart';
import 'package:gender_reveal/global/environment.dart';
import 'package:gender_reveal/services/local_storage.dart';

// Metodos y propiedades esaticas para no tener que inicializarlo instanciarlo
class GenderRevealApi {
  static Dio _dio = new Dio(); // instanciando Dio

  /// Metodo para configurar Dio, que se llamara en dos lugares
  /// lleva configurados los headers
  static void configuraDio() {
    // base URL
    // _dio.options.baseUrl = 'http://localhost:8080/api'; // en modo desarrollo
    _dio.options.baseUrl = Environment.baseUrl; // en modo desarrollo
    // modo produccion
    // _dio.options.baseUrl = 'https://flutter-web-admin-curso.herokuapp.com/api';
    /** 
     * Configurar los Headers
     * para enviar en los headers el toquen lo buscamos 
     * en el LocalStorage en caso que no lo encuentre 
     * pasamos un String vacio 
     */
    _dio.options.headers = {'x-token': LocalStorage.prefs.getString('token') ?? ''};
  }

  /// Petición asincrona, necesita el path
  static Future httpGet(String path) async {
    try {
      // realizando la peticion Http
      final resp = await _dio.get(path); // retorna un json object
      return resp.data;
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el GET');
    }
  }

  /// Petición post asincrona, necesita el path y un Map
  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      // realizando la peticion Http
      final resp = await _dio.post(path, data: formData); // retorna un json object
      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el POST');
    }
  }
}
