import 'package:hive/hive.dart';

part 'meeting_model.g.dart';

@HiveType(typeId: 0)
class MeetingModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late String startTime;

  @HiveField(5)
  late String endTime;

  @HiveField(6)
  late List<String> participants;

  @HiveField(7)
  late String location;

  @HiveField(8)
  late bool isCompleted;

  @HiveField(9)
  late DateTime createdAt;

  @HiveField(10)
  late DateTime? updatedAt;

  MeetingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.participants = const [],
    required this.location,
    this.isCompleted = false,
    required this.createdAt,
    this.updatedAt,
  });

  // Método para criar uma cópia com alterações
  MeetingModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    String? startTime,
    String? endTime,
    List<String>? participants,
    String? location,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MeetingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      participants: participants ?? this.participants,
      location: location ?? this.location,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Método para verificar se a reunião é futura
  bool get isFuture {
    return date.isAfter(DateTime.now());
  }

  // Método para obter data e hora formatadas
  String get formattedDateTime {
    return '$startTime - $endTime';
  }
}
