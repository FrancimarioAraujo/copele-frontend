import 'package:copelefrontend/modules/meeting/models/meeting_model.dart';
import 'package:copelefrontend/modules/meeting/repositories/meeting_repository.dart';
import 'package:mobx/mobx.dart';

part 'meetings_controller.g.dart';

class MeetingsController = _MeetingsControllerBase with _$MeetingsController;

abstract class _MeetingsControllerBase with Store {
  final MeetingRepository _repository;

  _MeetingsControllerBase(this._repository);

  @observable
  ObservableList<MeetingModel> meetings = ObservableList<MeetingModel>();

  @observable
  ObservableList<MeetingModel> futureMeetings = ObservableList<MeetingModel>();

  @observable
  ObservableList<MeetingModel> completedMeetings = ObservableList<MeetingModel>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  int futureMeetingsCount = 0;

  @observable
  int completedMeetingsCount = 0;

  @action
  Future<void> loadMeetings() async {
    try {
      isLoading = true;
      errorMessage = null;
      
      final allMeetings = await _repository.getAll();
      meetings = ObservableList.of(allMeetings);
      
      await updateCounts();
    } catch (e) {
      errorMessage = 'Erro ao carregar reuniões: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadFutureMeetings() async {
    try {
      isLoading = true;
      errorMessage = null;
      
      final future = await _repository.getFuture();
      futureMeetings = ObservableList.of(future);
    } catch (e) {
      errorMessage = 'Erro ao carregar reuniões futuras: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadCompletedMeetings() async {
    try {
      isLoading = true;
      errorMessage = null;
      
      final completed = await _repository.getCompleted();
      completedMeetings = ObservableList.of(completed);
    } catch (e) {
      errorMessage = 'Erro ao carregar reuniões completas: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createMeeting(MeetingModel meeting) async {
    try {
      isLoading = true;
      errorMessage = null;
      
      final newMeeting = await _repository.create(meeting);
      meetings.add(newMeeting);
      
      if (newMeeting.isFuture && !newMeeting.isCompleted) {
        futureMeetings.add(newMeeting);
      }
      
      await updateCounts();
    } catch (e) {
      errorMessage = 'Erro ao criar reunião: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateMeeting(String id, MeetingModel meeting) async {
    try {
      isLoading = true;
      errorMessage = null;
      
      await _repository.update(id, meeting);
      
      final index = meetings.indexWhere((m) => m.id == id);
      if (index != -1) {
        meetings[index] = meeting;
      }
      
      await updateCounts();
    } catch (e) {
      errorMessage = 'Erro ao atualizar reunião: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> completeMeeting(String id) async {
    try {
      isLoading = true;
      errorMessage = null;
      
      await _repository.markAsCompleted(id);
      
      final meeting = await _repository.getById(id);
      if (meeting != null) {
        final index = meetings.indexWhere((m) => m.id == id);
        if (index != -1) {
          meetings[index] = meeting;
        }
        
        final futureIndex = futureMeetings.indexWhere((m) => m.id == id);
        if (futureIndex != -1) {
          futureMeetings.removeAt(futureIndex);
        }
        
        completedMeetings.add(meeting);
      }
      
      await updateCounts();
    } catch (e) {
      errorMessage = 'Erro ao marcar reunião como completa: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteMeeting(String id) async {
    try {
      isLoading = true;
      errorMessage = null;
      
      await _repository.delete(id);
      
      meetings.removeWhere((m) => m.id == id);
      futureMeetings.removeWhere((m) => m.id == id);
      completedMeetings.removeWhere((m) => m.id == id);
      
      await updateCounts();
    } catch (e) {
      errorMessage = 'Erro ao deletar reunião: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> searchMeetings(String query) async {
    try {
      isLoading = true;
      errorMessage = null;
      
      if (query.isEmpty) {
        await loadMeetings();
      } else {
        final results = await _repository.search(query);
        meetings = ObservableList.of(results);
      }
    } catch (e) {
      errorMessage = 'Erro ao pesquisar reuniões: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateCounts() async {
    futureMeetingsCount = meetings.where((m) => m.isFuture && !m.isCompleted).length;
    completedMeetingsCount = meetings.where((m) => m.isCompleted).length;
  }

  // Método público para obter reunião por ID
  Future<MeetingModel?> getMeetingById(String id) async {
    return await _repository.getById(id);
  }
}