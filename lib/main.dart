import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gender_reveal/api/gender_reveal_api.dart';

import 'package:gender_reveal/router/router.dart';
import 'package:gender_reveal/providers/auth_provider.dart';
import 'package:gender_reveal/providers/socket_provider.dart';

import 'package:gender_reveal/services/notification_services.dart';
import 'package:gender_reveal/services/navigation_services.dart';
import 'package:gender_reveal/services/local_storage.dart';

import 'package:gender_reveal/ui/layouts/auth/auth_layout.dart';
import 'package:gender_reveal/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:gender_reveal/ui/layouts/splash/splash_layout.dart';

void main() async {
  await LocalStorage.configurePrefs();
  GenderRevealApi.configuraDio();
  Flurorouter.configureRoute();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SocketProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: Flurorouter.rootRoute,
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);
        if (authProvider.authStatus == AuthStatus.cheking) return SplashLayout();

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
    );
  }
}
