import 'package:copelefrontend/modules/reuniao/models/meeting_model.dart';
import 'package:copelefrontend/modules/reuniao/services/reuniao_service.dart';


class ReuniaoController {
  final ReuniaoService service;

  ReuniaoController(this.service);

  List<MeetingModel> reunioes = [];

  Future<void> fetchMeets() async {
    reunioes = await service.buscarReunioes();
  }

  Future<void> salvarReuniao(Map<String, dynamic> data) async {
    await service.criarReuniao(data);
  }
}