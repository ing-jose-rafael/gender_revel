import 'package:flutter/material.dart';
import 'package:gender_reveal/datatable/users_datasource.dart';
import 'package:gender_reveal/models/usuario_model.dart';
import 'package:gender_reveal/providers/socket_provider.dart';
import 'package:gender_reveal/router/router.dart';
import 'package:gender_reveal/services/navigation_services.dart';

import 'package:gender_reveal/ui/layouts/auth/widgets/custom_title.dart';
import 'package:gender_reveal/ui/layouts/splash/splash_layout.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

// import 'package:gender_reveal/providers/auth_provider.dart';

import 'package:gender_reveal/ui/cards/white_card.dart';

class DashboardViewResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<AuthProvider>(context).user!;
    final socketProvider = Provider.of<SocketProvider>(context);
    final sourceUser = new UsersDTS(socketProvider.usersVoto);
    // final bool mostarUserVoto = (user.nombre == 'Karen Brochado' || user.nombre == 'test9') ? true : false;
    // final String text =
    //     socketProvider.generos!.first.voto.toString().isEmpty ? '' : socketProvider.generos!.first.voto.toString();
    // socketProvider.socket.on('resultado', (payload) => {print(payload)});
    // socketProvider.connect();
    return (socketProvider.procesandoVoto == ServecesStatusVoto.Votando)
        ? SplashLayout(titulo: 'Procesando su voto...')
        : Container(
            padding: const EdgeInsets.only(left: 20, right: 10.0, top: 10, bottom: 10),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                // Text('Niño o Niña? test ${user.nombre}', style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold)),
                CustomTile2(
                  title: 'Jose & Karen',
                  fontSize: 20,
                  heightImg: 60,
                  alignmentCenter: false,
                  onPressed: () => NavigationService.replaceTo(Flurorouter.dashboardRoute),
                  // Provider.of<SocketProvider>(context, listen: false).disconnect();
                  // Provider.of<AuthProvider>(context, listen: false).logout();
                ),
                // SizedBox(height: 10),
                WhitrCard(
                  title: 'Niño o Niña ?',
                  //'Resultados del Sondeo ${socketProvider.servecesStatus} -${socketProvider.generos.first.voto} - ${socketProvider.generos.last.voto}',
                  child: ResultGrafic(
                    vMasculino: socketProvider.votoMas,
                    vFemeninos: socketProvider.votoFem,
                  ),
                ),
                // Text('Ranking Niña', style: GoogleFonts.roboto(fontSize: 17)),
                // BuildListaVotantes(users: socketProvider.usersMaxF),
                // Text('Ranking Niño', style: GoogleFonts.roboto(fontSize: 17)),
                // BuildListaVotantes(users: socketProvider.usersMaxM),
                PaginatedDataTable(
                  sortAscending: socketProvider.ascending,
                  sortColumnIndex: socketProvider.sortColumnIdex,
                  columns: [
                    DataColumn(
                      label: Text('Nombre', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                        label: Text('Niña', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold)),
                        onSort: (colIndex, asc) {
                          socketProvider.sortColumnIdex = colIndex;
                          socketProvider.sort<num>((user) => user.votoF);
                        }),
                    DataColumn(
                        label: Text('Niño', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold)),
                        onSort: (colIndex, asc) {
                          socketProvider.sortColumnIdex = colIndex;
                          socketProvider.sort<num>((user) => user.votoM);
                        }),
                  ],
                  source: sourceUser,
                )
              ],
            ),
          );
  }
}

class BuildListaVotantes extends StatelessWidget {
  final List<Usuario> users;
  const BuildListaVotantes({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      // color: Colors.grey,
      width: double.infinity,
      height: 330,
      child: ListViewUser(
        users: users,
      ),
    );
  }
}

class ListViewUser extends StatelessWidget {
  final List<Usuario> users;

  const ListViewUser({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) => UserListTitle(user: users[index]),
      separatorBuilder: (_, i) => Divider(),
    );
  }
}

class UserListTitle extends StatelessWidget {
  final Usuario user;
  const UserListTitle({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = (user.color == 1) ? Color(int.parse('0xff5CA5D1')) : Color(int.parse('0xffE8A7BE'));
    return ListTile(
      title: Text(user.nombre),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: color,
          // color: user.online ? Colors.green[300] : Colors.red[300],
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

class ResultGrafic extends StatelessWidget {
  final int vMasculino, vFemeninos;
  const ResultGrafic({Key? key, required this.vMasculino, required this.vFemeninos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FittedBox(
        //   child: Text(
        //     'Resultados',
        //     style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(width: 20),

            // Container(width: 20, height: 20, color: Colors.black),
            LegendIndicator(color: Color(0xffFBC7DE), titulo: 'Niña', votos: vFemeninos),
            Expanded(child: Grafico()),
            LegendIndicator(color: Colors.blue[200]!, titulo: 'Niño', votos: vMasculino),
            // SizedBox(width: 30),
          ],
        ),
      ],
    );
  }
}

class Grafico extends StatelessWidget {
  const Grafico({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 170,
      // color: Colors.pink,s
      child: Stack(
        children: [
          PieChartSample2(),
          Align(child: CustomImagenPorcent()),
        ],
      ),
    );
  }
}

class CustomImagenPorcent extends StatelessWidget {
  const CustomImagenPorcent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketProvider>(context);
    final image = (socketProvider.votoFem > socketProvider.votoMas)
        ? 'assets/icons8-embarazada-80.png'
        : 'assets/icons8-embarazada-81.png';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, width: 34, height: 34),
        FittedBox(
          child: Text(
            '${socketProvider.porcentaje.toStringAsFixed(0)} %',
            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class PieChartSample2 extends StatelessWidget {
  const PieChartSample2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketProvider>(context);
    Map<String, double> dataMap = {
      "Flutter": socketProvider.votoMas.toDouble(),
      "React": socketProvider.votoFem.toDouble(),
    };
    final List<Color> colorList = [
      Colors.blue[200]!,
      Color(0xffFBC7DE),
    ];
    return Container(
      width: double.infinity,
      // height: 180,
      // color: Colors.white,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 60,
        chartRadius: MediaQuery.of(context).size.width / 4.1,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 14,
        centerText: null,
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: false,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: false,
          showChartValues: false,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

class LegendIndicator extends StatelessWidget {
  const LegendIndicator({Key? key, required this.color, required this.titulo, required this.votos}) : super(key: key);
  final Color color;
  final String titulo;
  final int votos;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                // backgroundColor: Color(0xffFBC7DE),
                backgroundColor: color,
                radius: 3.5,
              ),
              SizedBox(width: 3),
              FittedBox(child: Text(titulo, style: GoogleFonts.roboto(fontSize: 17))),
            ],
          ),
          FittedBox(
            child: Text(
              '$votos',
              style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
