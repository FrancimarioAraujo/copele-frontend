import 'package:copelefrontend/modules/reuniao/controllers/reuniao_controller.dart';
import 'package:copelefrontend/modules/reuniao/pages/reuniao_page.dart';
import 'package:copelefrontend/modules/reuniao/services/reuniao_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ReuniaoModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(ReuniaoService.new);
    i.addLazySingleton(ReuniaoController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => ReuniaoPage());
  }
}