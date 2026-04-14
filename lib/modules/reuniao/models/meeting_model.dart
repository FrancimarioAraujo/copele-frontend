class MeetingModel {
  final String date;
  final String startTime;
  final String secretary;
  final List<String> participants;
  final List<Topic> topics;

  MeetingModel({
    required this.date,
    required this.startTime,
    required this.secretary,
    required this.participants,
    required this.topics,
  });

  factory MeetingModel.fromJson(Map json) {
    final meeting = json['reuniao'];

    return MeetingModel(
      date: meeting['data'],
      startTime: meeting['hora_inicio'],
      secretary: meeting['secretario'],
      participants: List<String>.from(meeting['participantes']),
      topics: (meeting['pautas'] as List)
          .map((e) => Topic.fromJson(e))
          .toList(),
    );
  }
}

class Topic {
  final String id;
  final String description;
  final String status;

  Topic({
    required this.id,
    required this.description,
    required this.status,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      description: json['descricao'],
      status: json['status'],
    );
  }
}