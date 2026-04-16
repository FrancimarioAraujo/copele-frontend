// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MeetingsController on _MeetingsControllerBase, Store {
  late final _$meetingsAtom =
      Atom(name: '_MeetingsControllerBase.meetings', context: context);

  @override
  ObservableList<MeetingModel> get meetings {
    _$meetingsAtom.reportRead();
    return super.meetings;
  }

  @override
  set meetings(ObservableList<MeetingModel> value) {
    _$meetingsAtom.reportWrite(value, super.meetings, () {
      super.meetings = value;
    });
  }

  late final _$futureMeetingsAtom =
      Atom(name: '_MeetingsControllerBase.futureMeetings', context: context);

  @override
  ObservableList<MeetingModel> get futureMeetings {
    _$futureMeetingsAtom.reportRead();
    return super.futureMeetings;
  }

  @override
  set futureMeetings(ObservableList<MeetingModel> value) {
    _$futureMeetingsAtom.reportWrite(value, super.futureMeetings, () {
      super.futureMeetings = value;
    });
  }

  late final _$completedMeetingsAtom =
      Atom(name: '_MeetingsControllerBase.completedMeetings', context: context);

  @override
  ObservableList<MeetingModel> get completedMeetings {
    _$completedMeetingsAtom.reportRead();
    return super.completedMeetings;
  }

  @override
  set completedMeetings(ObservableList<MeetingModel> value) {
    _$completedMeetingsAtom.reportWrite(value, super.completedMeetings, () {
      super.completedMeetings = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_MeetingsControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_MeetingsControllerBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$futureMeetingsCountAtom = Atom(
      name: '_MeetingsControllerBase.futureMeetingsCount', context: context);

  @override
  int get futureMeetingsCount {
    _$futureMeetingsCountAtom.reportRead();
    return super.futureMeetingsCount;
  }

  @override
  set futureMeetingsCount(int value) {
    _$futureMeetingsCountAtom.reportWrite(value, super.futureMeetingsCount, () {
      super.futureMeetingsCount = value;
    });
  }

  late final _$completedMeetingsCountAtom = Atom(
      name: '_MeetingsControllerBase.completedMeetingsCount', context: context);

  @override
  int get completedMeetingsCount {
    _$completedMeetingsCountAtom.reportRead();
    return super.completedMeetingsCount;
  }

  @override
  set completedMeetingsCount(int value) {
    _$completedMeetingsCountAtom
        .reportWrite(value, super.completedMeetingsCount, () {
      super.completedMeetingsCount = value;
    });
  }

  late final _$loadMeetingsAsyncAction =
      AsyncAction('_MeetingsControllerBase.loadMeetings', context: context);

  @override
  Future<void> loadMeetings() {
    return _$loadMeetingsAsyncAction.run(() => super.loadMeetings());
  }

  late final _$loadFutureMeetingsAsyncAction = AsyncAction(
      '_MeetingsControllerBase.loadFutureMeetings',
      context: context);

  @override
  Future<void> loadFutureMeetings() {
    return _$loadFutureMeetingsAsyncAction
        .run(() => super.loadFutureMeetings());
  }

  late final _$loadCompletedMeetingsAsyncAction = AsyncAction(
      '_MeetingsControllerBase.loadCompletedMeetings',
      context: context);

  @override
  Future<void> loadCompletedMeetings() {
    return _$loadCompletedMeetingsAsyncAction
        .run(() => super.loadCompletedMeetings());
  }

  late final _$createMeetingAsyncAction =
      AsyncAction('_MeetingsControllerBase.createMeeting', context: context);

  @override
  Future<void> createMeeting(MeetingModel meeting) {
    return _$createMeetingAsyncAction.run(() => super.createMeeting(meeting));
  }

  late final _$updateMeetingAsyncAction =
      AsyncAction('_MeetingsControllerBase.updateMeeting', context: context);

  @override
  Future<void> updateMeeting(String id, MeetingModel meeting) {
    return _$updateMeetingAsyncAction
        .run(() => super.updateMeeting(id, meeting));
  }

  late final _$completeMeetingAsyncAction =
      AsyncAction('_MeetingsControllerBase.completeMeeting', context: context);

  @override
  Future<void> completeMeeting(String id) {
    return _$completeMeetingAsyncAction.run(() => super.completeMeeting(id));
  }

  late final _$deleteMeetingAsyncAction =
      AsyncAction('_MeetingsControllerBase.deleteMeeting', context: context);

  @override
  Future<void> deleteMeeting(String id) {
    return _$deleteMeetingAsyncAction.run(() => super.deleteMeeting(id));
  }

  late final _$searchMeetingsAsyncAction =
      AsyncAction('_MeetingsControllerBase.searchMeetings', context: context);

  @override
  Future<void> searchMeetings(String query) {
    return _$searchMeetingsAsyncAction.run(() => super.searchMeetings(query));
  }

  late final _$updateCountsAsyncAction =
      AsyncAction('_MeetingsControllerBase.updateCounts', context: context);

  @override
  Future<void> updateCounts() {
    return _$updateCountsAsyncAction.run(() => super.updateCounts());
  }

  @override
  String toString() {
    return '''
meetings: ${meetings},
futureMeetings: ${futureMeetings},
completedMeetings: ${completedMeetings},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
futureMeetingsCount: ${futureMeetingsCount},
completedMeetingsCount: ${completedMeetingsCount}
    ''';
  }
}
