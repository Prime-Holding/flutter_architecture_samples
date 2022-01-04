// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'todo_manage_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class TodoManageBlocType extends RxBlocTypeBase {
  TodoManageBlocEvents get events;
  TodoManageBlocStates get states;
}

/// [$TodoManageBloc] extended by the [TodoManageBloc]
/// {@nodoc}
abstract class $TodoManageBloc extends RxBlocBase
    implements TodoManageBlocEvents, TodoManageBlocStates, TodoManageBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [save]
  final _$saveEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [setTask]
  final _$setTaskEvent = BehaviorSubject<String>();

  /// Тhe [Subject] where events sink to by calling [setNote]
  final _$setNoteEvent = BehaviorSubject<String>();

  /// The state of [isLoading] implemented in [_mapToIsLoadingState]
  late final Stream<bool> _isLoadingState = _mapToIsLoadingState();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [task] implemented in [_mapToTaskState]
  late final Stream<String> _taskState = _mapToTaskState();

  /// The state of [note] implemented in [_mapToNoteState]
  late final Stream<String> _noteState = _mapToNoteState();

  /// The state of [saved] implemented in [_mapToSavedState]
  late final Stream<TodoEntity> _savedState = _mapToSavedState();

  @override
  void save() => _$saveEvent.add(null);

  @override
  void setTask(String task) => _$setTaskEvent.add(task);

  @override
  void setNote(String note) => _$setNoteEvent.add(note);

  @override
  Stream<bool> get isLoading => _isLoadingState;

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<String> get task => _taskState;

  @override
  Stream<String> get note => _noteState;

  @override
  Stream<TodoEntity> get saved => _savedState;

  Stream<bool> _mapToIsLoadingState();

  Stream<String> _mapToErrorsState();

  Stream<String> _mapToTaskState();

  Stream<String> _mapToNoteState();

  Stream<TodoEntity> _mapToSavedState();

  @override
  TodoManageBlocEvents get events => this;

  @override
  TodoManageBlocStates get states => this;

  @override
  void dispose() {
    _$saveEvent.close();
    _$setTaskEvent.close();
    _$setNoteEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
