import 'dart:convert';

class Usuario {
  Usuario({
    required this.rol,
    required this.estado,
    required this.nombre,
    required this.celular,
    required this.uid,
    required this.votoM,
    required this.votoF,
    this.createdAt,
    this.updatedAt,
    this.color,
  });

  String rol;
  bool estado;

  String nombre;
  int celular;
  String uid;
  int? color;
  int votoM;
  int votoF;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        rol: json["rol"],
        estado: json["estado"],
        nombre: json["nombre"],
        celular: json["celular"],
        uid: json["uid"],
        votoM: json["votoM"],
        votoF: json["votoF"],
        color: json["color"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "rol": rol,
        "estado": estado,
        "nombre": nombre,
        "celular": celular,
        "uid": uid,
        "votoM": votoM,
        "votoF": votoF,
        "color": color,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
