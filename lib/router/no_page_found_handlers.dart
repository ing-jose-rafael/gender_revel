import 'package:fluro/fluro.dart';
// import 'package:provider/provider.dart';
import 'package:gender_reveal/ui/views/no_page_found_view.dart';
// import 'package:admin_dashboard/providers/sidemenu_provider.dart';
// import 'package:admin_dashboard/ui/views/no_page_found_view.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, parmas) {
    // Provider.of<SideMenuProvider>(context!, listen: false).setCurrentPage('/404');
    return NoPageFoundView();
  });
}
