import 'package:copelefrontend/home_page.dart';
import 'package:copelefrontend/modules/reuniao/reuniao_module.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: ReuniaoModule());
  }
}