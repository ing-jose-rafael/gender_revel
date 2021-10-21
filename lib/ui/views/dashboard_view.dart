import 'package:flutter/material.dart';
import 'package:gender_reveal/models/usuario_model.dart';
import 'package:gender_reveal/providers/socket_provider.dart';

import 'package:gender_reveal/ui/layouts/auth/widgets/custom_title.dart';
import 'package:gender_reveal/ui/layouts/splash/splash_layout.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:gender_reveal/providers/auth_provider.dart';

import 'package:gender_reveal/ui/cards/white_card.dart';
import 'package:gender_reveal/ui/layouts/dashboard/widgets/button_gender.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;
    final socketProvider = Provider.of<SocketProvider>(context);
    final bool mostarUserVoto = (user.rol == 'ADMIN_ROLE') ? true : false;
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
                  mostarResultUser: mostarUserVoto,
                  onPressed: () {
                    Provider.of<SocketProvider>(context, listen: false).disconnect();
                    Provider.of<AuthProvider>(context, listen: false).logout();
                  },
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

                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal, // crea los elementos hoorizontal

                  // spacing: 5,
                  alignment: WrapAlignment.spaceEvenly,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomBtnTeam(
                      img: 'assets/icons8-baby-girl-64.png',
                      generel: 'Niña',
                      color: Color(0xffFBC7DE),
                      imgGender: 'assets/icons8-mujer-48.png',
                      onPressed: () => votar(socketProvider, socketProvider.generos!.last.id, user, 0, context),
                    ),
                    // SizedBox(width: 10),
                    CustomBtnTeam(
                      img: 'assets/icons8-baby-girl-65.png',
                      generel: 'Niño',
                      color: Colors.blue[100]!,
                      imgGender: 'assets/icons8-hombre-48.png',
                      onPressed: () => votar(socketProvider, socketProvider.generos!.first.id, user, 1, context),
                    ),
                  ],
                ),

                BuildListaVotantes(users: socketProvider.users),
              ],
            ),
          );
  }

  void votar(SocketProvider socketProvider, String id, Usuario user, int vGenero, BuildContext context) {
    Map<String, dynamic> dta;
    socketProvider.procesandoVoto = ServecesStatusVoto.Votando;
    if (vGenero == 1) {
      dta = {'id': id, 'idUser': user.uid, 'votoM': 1, 'color': vGenero};
    } else {
      dta = {'id': id, 'idUser': user.uid, 'votoF': 1, 'color': vGenero};
    }
    // NotificationsService.showBusyIndicator(context);
    socketProvider.socket.emit('votar', dta);
    // if (socketProvider.procesandoVoto == ServecesStatusVoto.Voto) Navigator.of(context).pop();
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
