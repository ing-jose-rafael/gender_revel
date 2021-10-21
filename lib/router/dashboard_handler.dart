import 'package:fluro/fluro.dart';
import 'package:gender_reveal/providers/socket_provider.dart';
import 'package:gender_reveal/ui/views/dashboard_view.dart';
import 'package:gender_reveal/ui/views/dashboard_view_userVoto.dart';
import 'package:gender_reveal/ui/views/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:gender_reveal/providers/auth_provider.dart';
import 'package:gender_reveal/ui/views/login_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, parms) {
    final authProvider = Provider.of<AuthProvider>(context!);
    // Provider.of<SideMenuProvider>(context, listen: false).setCurrentPage(Flurorouter.dashboardRoute);
    final SocketProvider socketProvider = Provider.of<SocketProvider>(context);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (socketProvider.servecesStatusDta == ServecesStatusDta.hasData) return DashboardView();
      return SplashView();
    } else {
      return LoginView();
    }
  });
  static Handler result = Handler(handlerFunc: (context, parms) {
    final authProvider = Provider.of<AuthProvider>(context!);
    // Provider.of<SideMenuProvider>(context, listen: false).setCurrentPage(Flurorouter.dashboardRoute);
    final SocketProvider socketProvider = Provider.of<SocketProvider>(context);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (socketProvider.servecesStatusDta == ServecesStatusDta.hasData) return DashboardViewResult();
      return SplashView();
    } else {
      return LoginView();
    }
  });

  // static Handler icons = Handler(handlerFunc: (context, parms) {
  //   final authProvider = Provider.of<AuthProvider>(context!);
  //   Provider.of<SideMenuProvider>(context, listen: false).setCurrentPage(Flurorouter.iconsRoute);
  //   if (authProvider.authStatus == AuthStatus.authenticated)
  //     return IconsView();
  //   else
  //     /**aca si no esta autenticado puedo mandar un 404 */
  //     return LoginView();
  // });

  // static Handler blank = Handler(handlerFunc: (context, parms) {
  //   final authProvider = Provider.of<AuthProvider>(context!);
  //   Provider.of<SideMenuProvider>(context, listen: false).setCurrentPage(Flurorouter.blankRoute);
  //   if (authProvider.authStatus == AuthStatus.authenticated)
  //     return BlankView();
  //   else
  //     /**aca si no esta autenticado puedo mandar un 404 */
  //     return LoginView();
  // });

  // static Handler category = Handler(handlerFunc: (context, parms) {
  //   final authProvider = Provider.of<AuthProvider>(context!);
  //   Provider.of<SideMenuProvider>(context, listen: false).setCurrentPage(Flurorouter.categoryRoute);
  //   if (authProvider.authStatus == AuthStatus.authenticated)
  //     return CategoriesView();
  //   else
  //     /**aca si no esta autenticado puedo mandar un 404 */
  //     return LoginView();
  // });

  // static Handler users = Handler(handlerFunc: (context, parms) {
  //   final authProvider = Provider.of<AuthProvider>(context!);
  //   Provider.of<SideMenuProvider>(context, listen: false).setCurrentPage(Flurorouter.usersRoute);
  //   if (authProvider.authStatus == AuthStatus.authenticated)
  //     return UsersView();
  //   else
  //     /**aca si no esta autenticado puedo mandar un 404 */
  //     return LoginView();
  // });
  // static Handler user = Handler(handlerFunc: (context, params) {
  //   final authProvider = Provider.of<AuthProvider>(context!);
  //   Provider.of<SideMenuProvider>(context, listen: false).setCurrentPage(Flurorouter.userRoute);
  //   if (authProvider.authStatus == AuthStatus.authenticated) {
  //     // print(params);
  //     // verificando si tiene el uid el url
  //     if (params['uid']?.first != null) {
  //       return UserDetailsView(uid: params['uid']!.first);
  //     } else {
  //       return UsersView();
  //     }
  //   } else {
  //     /**aca si no esta autenticado puedo mandar un 404 */
  //     return LoginView();
  //   }
  // });
}
