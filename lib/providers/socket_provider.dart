import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gender_reveal/global/environment.dart';
import 'package:gender_reveal/models/http/genero_response.dart';
import 'package:gender_reveal/models/usuario_model.dart';
import 'package:gender_reveal/services/local_storage.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServecesStatus { Online, Offline, Connecting }
enum ServecesStatusVoto { Voto, Votando, Connecting }
enum ServecesStatusDta { hasData, notData }

class SocketProvider with ChangeNotifier {
  // creando la propiedad, por default estará en Connecting, dado que cuando creo la instancia
  // no se si esta Online o Offline
  ServecesStatus _servecesStatus = ServecesStatus.Connecting;
  ServecesStatusDta _servecesStatusDta = ServecesStatusDta.notData;
  ServecesStatusVoto _procesandoVoto = ServecesStatusVoto.Connecting;
  int votoMas = 0;
  int votoFem = 0;
  double porcentaje = 0.0;
  bool ascending = true;
  int? sortColumnIdex;

  late Socket _socket;
  List<Genero>? generos;
  List<Usuario> users = [];
  List<Usuario> usersVoto = [];
  // List<Usuario> usersMaxM = [];

  // SocketProvider() {
  //   this._connect();
  // }
  void connect() {
    // obtener el token
    final token = LocalStorage.prefs.getString('token');

    // print(token);
    // Dart client
    // IO.Socket socket = IO.io('http://localhost:3000');
    this._socket = io(
        Environment.socketUrl,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            // .enableForceNew()
            .disableAutoConnect() // disable auto-connection
            //.enableAutoConnect()
            .setExtraHeaders({'x-token': token}) // optional
            .build());
    // print(this._socket.opts!['extraHeaders']);
    this._socket.connect();
    this._socket.onConnect((_) {
      //print('connectado');
      this._servecesStatus = ServecesStatus.Online;
      notifyListeners();
    });
    this._socket.onDisconnect((_) {
      //print('disconnect');

      this._servecesStatus = ServecesStatus.Offline;
      notifyListeners();
    });
    this._socket.on('resultado', (data) {
      final rep = jsonDecode(data);

      final resp = ResponseResultGener.fromMap(rep);

      this.users = resp.usuario;
      this.generos = resp.genero;
      this.usersVoto = resp.usersVoto;
      // this.usersMaxM = resp.usersVoto;

      this._servecesStatusDta = ServecesStatusDta.hasData;
      this.votoMas = generos!.first.voto;
      this.votoFem = generos!.last.voto;
      final votoMayor = (generos!.first.voto > generos!.last.voto) ? generos!.first.voto : generos!.last.voto;
      this.porcentaje = (votoMayor / (generos!.first.voto + generos!.last.voto) * 100);
      this._procesandoVoto = ServecesStatusVoto.Voto;
      // print('paso por aqui');
      notifyListeners();
      // print(resp.genero.first.voto);
      // print(resp.genero);
    });
    // this._socket.on('event', (data) => print(data));
    // this._socket.onDisconnect((_) => print('disconnect'));
    // this._socket.on('fromServer', (_) => print(_));
  }

  // para desconectarnos de socket
  void disconnect() {
    this._procesandoVoto = ServecesStatusVoto.Connecting;
    this._socket.disconnect();
  }

  ServecesStatus get servecesStatus => this._servecesStatus;
  ServecesStatusDta get servecesStatusDta => this._servecesStatusDta;

  Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  set procesandoVoto(ServecesStatusVoto value) {
    this._procesandoVoto = value;
    notifyListeners();
  }

  ServecesStatusVoto get procesandoVoto => this._procesandoVoto;

  /// funsion generica para ordear, pide el campo por cual ordenar
  void sort<T>(Comparable<T> Function(Usuario user) getField) {
    usersVoto.sort((user1, user2) {
      final user1Value = getField(user1); // retorna el campo que quiero obtener
      final user2Value = getField(user2); // retorna el campo que quiero obtener
      // operacion de comparación
      return ascending ? Comparable.compare(user1Value, user2Value) : Comparable.compare(user2Value, user1Value);
    });
    ascending = !ascending;
    // notificamos por que se cambio  el arreglo
    notifyListeners();
  }
}
