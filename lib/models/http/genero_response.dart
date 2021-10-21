// import 'dart:convert';

import 'package:gender_reveal/models/usuario_model.dart';

// ResponseResultGener responseResultGenerFromMap(String str) => ResponseResultGener.fromMap(json.decode(str));

// String responseResultGenerToMap(ResponseResultGener data) => json.encode(data.toMap());

// class ResponseResultGener {
//   ResponseResultGener({
//     required this.genero,
//     required this.usuario,
//   });

//   List<Genero> genero;
//   List<Usuario> usuario;

//   factory ResponseResultGener.fromMap(Map<String, dynamic> json) => ResponseResultGener(
//         genero: List<Genero>.from(json["genero"].map((x) => Genero.fromMap(x))),
//         usuario: List<Usuario>.from(json["usuario"].map((x) => Usuario.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "genero": List<dynamic>.from(genero.map((x) => x.toMap())),
//         "usuario": List<dynamic>.from(usuario.map((x) => x.toMap())),
//       };
// }

// class Genero {
//   Genero({
//     required this.voto,
//     required this.id,
//     required this.genero,
//   });

//   int voto;
//   String id;
//   String genero;

//   factory Genero.fromMap(Map<String, dynamic> json) => Genero(
//         voto: json["voto"],
//         id: json["_id"],
//         genero: json["genero"],
//       );

//   Map<String, dynamic> toMap() => {
//         "voto": voto,
//         "_id": id,
//         "genero": genero,
//       };
// }
// To parse this JSON data, do
//
//     final responseResultGener = responseResultGenerFromMap(jsonString);

import 'dart:convert';

ResponseResultGener responseResultGenerFromMap(String str) => ResponseResultGener.fromMap(json.decode(str));

String responseResultGenerToMap(ResponseResultGener data) => json.encode(data.toMap());

class ResponseResultGener {
  ResponseResultGener({
    required this.genero,
    required this.usuario,
    required this.usersVoto,
    // required this.usersMaxF,
  });

  List<Genero> genero;
  List<Usuario> usuario;
  List<Usuario> usersVoto;
  // List<Usuario> usersMaxF;

  factory ResponseResultGener.fromMap(Map<String, dynamic> json) => ResponseResultGener(
        genero: List<Genero>.from(json["genero"].map((x) => Genero.fromMap(x))),
        usuario: List<Usuario>.from(json["usuario"].map((x) => Usuario.fromMap(x))),
        usersVoto: List<Usuario>.from(json["usersVoto"].map((x) => Usuario.fromMap(x))),
        // usersMaxF: List<Usuario>.from(json["usersMaxF"].map((x) => Usuario.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "genero": List<dynamic>.from(genero.map((x) => x.toMap())),
        "usuario": List<dynamic>.from(usuario.map((x) => x.toMap())),
        "usersVoto": List<dynamic>.from(usersVoto.map((x) => x.toMap())),
        // "usersMaxF": List<dynamic>.from(usersMaxF.map((x) => x.toMap())),
      };
}

class Genero {
  Genero({
    required this.voto,
    required this.id,
    required this.genero,
  });

  int voto;
  String id;
  String genero;

  factory Genero.fromMap(Map<String, dynamic> json) => Genero(
        voto: json["voto"],
        id: json["_id"],
        genero: json["genero"],
      );

  Map<String, dynamic> toMap() => {
        "voto": voto,
        "_id": id,
        "genero": genero,
      };
}
