
import 'package:copelefrontend/modules/meeting/meeting_module.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: MeetingModule());
  }
}