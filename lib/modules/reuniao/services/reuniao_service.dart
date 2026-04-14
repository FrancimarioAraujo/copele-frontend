import 'dart:convert';
import 'package:copelefrontend/modules/reuniao/models/meeting_model.dart';
import 'package:http/http.dart' as http;

class ReuniaoService {
  final String baseUrl = 'http://localhost:3000/api/reunioes';

Future<List<MeetingModel>> buscarReunioes() async {
  final response = await http.get(
    Uri.parse(baseUrl),
  );

  if (response.statusCode == 200) {
    final List list = jsonDecode(response.body);

    return list.map((e) => MeetingModel.fromJson(e)).toList();
  } else {
    throw Exception('Erro ao buscar reuniões');
  }
}

  Future<void> criarReuniao(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao criar reunião');
    }
  }
}