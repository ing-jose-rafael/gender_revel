import 'package:fluro/fluro.dart';
import 'package:gender_reveal/providers/socket_provider.dart';
import 'package:gender_reveal/ui/views/dashboard_view.dart';
import 'package:provider/provider.dart';
import 'package:gender_reveal/providers/auth_provider.dart';
import 'package:gender_reveal/ui/views/login_view.dart';
import 'package:gender_reveal/ui/views/register_view.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, parmas) {
    final authProvider = Provider.of<AuthProvider>(context!);
    final SocketProvider socketProvider = Provider.of(context);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return LoginView();
    } else {
      socketProvider.connect();
      return DashboardView();
    }
  });
  static Handler register = Handler(handlerFunc: (context, parmas) {
    final authProvider = Provider.of<AuthProvider>(context!);
    final SocketProvider socketProvider = Provider.of(context);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return RegisterView();
    } else {
      socketProvider.connect();
      return DashboardView();
    }
  });
}
