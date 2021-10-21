import 'package:flutter/material.dart';
// import 'package:gender_reveal/ui/labels/custom_labels.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Text('Resultados de los Votos', style: CustomLabels.h1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
