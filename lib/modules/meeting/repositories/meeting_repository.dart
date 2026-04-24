import 'package:copelefrontend/modules/meeting/models/meeting_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class MeetingRepository {
  static const String boxName = 'meetings';
  Box<MeetingModel>? _box;
  bool _isInitialized = false;

  // Inicializar a caixa do Hive (lazy initialization)
  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MeetingModelAdapter());
    }
    _box = await Hive.openBox<MeetingModel>(boxName);
    _isInitialized = true;
  }

  // Obter a caixa (garantir que está inicializada)
  Future<Box<MeetingModel>> get box async {
    await _ensureInitialized();
    return _box!;
  }

  // Criar nova reunião
  Future<MeetingModel> create(MeetingModel meeting) async {
    final boxInstance = await box;
    final newMeeting = meeting.copyWith(
      id: const Uuid().v4(),
      createdAt: DateTime.now(),
    );
    await boxInstance.add(newMeeting);
    return newMeeting;
  }

  // Obter todas as reuniões
  Future<List<MeetingModel>> getAll() async {
    final boxInstance = await box;
    return boxInstance.values.toList();
  }

  // Obter reuniões futuras
  Future<List<MeetingModel>> getFuture() async {
    final boxInstance = await box;
    return boxInstance.values.where((meeting) => meeting.isFuture && !meeting.isCompleted).toList();
  }

  // Obter reuniões completas
  Future<List<MeetingModel>> getCompleted() async {
    final boxInstance = await box;
    return boxInstance.values.where((meeting) => meeting.isCompleted).toList();
  }

  // Obter reunião por ID
  Future<MeetingModel?> getById(String id) async {
    final boxInstance = await box;
    final meetings = boxInstance.values.toList();
    try {
      return meetings.firstWhere((meeting) => meeting.id == id);
    } catch (e) {
      return null;
    }
  }

  // Atualizar reunião
  Future<void> update(String key, MeetingModel meeting) async {
    final boxInstance = await box;
    final updatedMeeting = meeting.copyWith(
      updatedAt: DateTime.now(),
    );
    
    final meetings = boxInstance.values.toList();
    final index = meetings.indexWhere((m) => m.id == key);
    
    if (index != -1) {
      await boxInstance.putAt(index, updatedMeeting);
    }
  }

  // Marcar reunião como completa
  Future<void> markAsCompleted(String id) async {
    final boxInstance = await box;
    final meeting = await getById(id);
    if (meeting != null) {
      final updatedMeeting = meeting.copyWith(
        isCompleted: true,
        updatedAt: DateTime.now(),
      );
      
      final meetings = boxInstance.values.toList();
      final index = meetings.indexWhere((m) => m.id == id);
      
      if (index != -1) {
        await boxInstance.putAt(index, updatedMeeting);
      }
    }
  }

  // Deletar reunião
  Future<void> delete(String id) async {
    final boxInstance = await box;
    final meetings = boxInstance.values.toList();
    final index = meetings.indexWhere((m) => m.id == id);
    
    if (index != -1) {
      await boxInstance.deleteAt(index);
    }
  }

  // Deletar todas as reuniões
  Future<void> deleteAll() async {
    final boxInstance = await box;
    await boxInstance.clear();
  }

  // Contar reuniões
  Future<int> count() async {
    final boxInstance = await box;
    return boxInstance.length;
  }

  // Contar reuniões futuras
  Future<int> countFuture() async {
    final boxInstance = await box;
    return boxInstance.values.where((meeting) => meeting.isFuture && !meeting.isCompleted).length;
  }

  // Contar reuniões completas
  Future<int> countCompleted() async {
    final boxInstance = await box;
    return boxInstance.values.where((meeting) => meeting.isCompleted).length;
  }

  // Pesquisar reuniões por título
  Future<List<MeetingModel>> search(String query) async {
    final boxInstance = await box;
    return boxInstance.values
        .where((meeting) => 
            meeting.title.toLowerCase().contains(query.toLowerCase()) ||
            meeting.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Fechar a caixa
  Future<void> close() async {
    final boxInstance = await box;
    await boxInstance.close();
  }
}
