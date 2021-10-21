import 'package:flutter/material.dart';
import 'package:gender_reveal/models/usuario_model.dart';

class UsersDTS extends DataTableSource {
  final List<Usuario> users;
  UsersDTS(this.users);
  @override
  DataRow? getRow(int index) {
    final usuario = users[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(usuario.nombre)),
        DataCell(Text('${usuario.votoF}')),
        DataCell(Text('${usuario.votoM}')),
      ],
    );
  }

  // isRowCountApproximate => false; cuando el dato es exacto
  @override
  bool get isRowCountApproximate => false;

  @override
  // cantidad de row
  int get rowCount => this.users.length;

  @override
  int get selectedRowCount => 0;
}
