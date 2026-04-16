import 'package:copelefrontend/modules/meeting/controllers/meetings_controller.dart';
import 'package:copelefrontend/modules/meeting/repositories/meeting_repository.dart';
import 'package:copelefrontend/modules/meeting/pages/meetings_page.dart';
import 'package:copelefrontend/modules/meeting/pages/meeting_detail_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MeetingModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(() => MeetingRepository());
    i.addLazySingleton(() => MeetingsController(i<MeetingRepository>()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => MeetingsPage());
    r.child('/meeting-detail/:id', child: (_) => MeetingDetailPage(meetingId: r.args.params['id']));
  }
}