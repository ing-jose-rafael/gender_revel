// Configuracion basica de las rutas
import 'package:fluro/fluro.dart';
import 'package:gender_reveal/router/admin_handlers.dart';
import 'package:gender_reveal/router/dashboard_handler.dart';
import 'package:gender_reveal/router/no_page_found_handlers.dart';

class Flurorouter {
  static FluroRouter router = new FluroRouter();

  static String rootRoute = '/';
  // rutas para la autentificacion
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  // Auth Dashboard
  static String dashboardRoute = '/dashboard';
  static String dashboardRouteResult = '/dashboard/resutado';

  static void configureRoute() {
    router.define(rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none);

    // Dashboard Route
    router.define(dashboardRoute, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn);
    router.define(dashboardRouteResult, handler: DashboardHandlers.result, transitionType: TransitionType.fadeIn);
    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
