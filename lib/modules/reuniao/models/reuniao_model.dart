class ReuniaoModel {
  final String data;
  final String horaInicio;
  final String secretario;
  final List<String> participantes;
  final List<Pauta> pautas;

  ReuniaoModel({
    required this.data,
    required this.horaInicio,
    required this.secretario,
    required this.participantes,
    required this.pautas,
  });

  factory ReuniaoModel.fromJson(Map json) {
    final reuniao = json['reuniao'];

    return ReuniaoModel(
      data: reuniao['data'],
      horaInicio: reuniao['hora_inicio'],
      secretario: reuniao['secretario'],
      participantes: List<String>.from(reuniao['participantes']),
      pautas: (reuniao['pautas'] as List)
          .map((e) => Pauta.fromJson(e))
          .toList(),
    );
  }
}

class Pauta {
  final String id;
  final String descricao;
  final String status;

  Pauta({
    required this.id,
    required this.descricao,
    required this.status,
  });

  factory Pauta.fromJson(Map<String, dynamic> json) {
    return Pauta(
      id: json['id'],
      descricao: json['descricao'],
      status: json['status'],
    );
  }
}