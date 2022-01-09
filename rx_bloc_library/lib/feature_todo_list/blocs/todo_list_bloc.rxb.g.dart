// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'todo_list_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class TodoListBlocType extends RxBlocTypeBase {
  TodoListBlocEvents get events;
  TodoListBlocStates get states;
}

/// [$TodoListBloc] extended by the [TodoListBloc]
/// {@nodoc}
abstract class $TodoListBloc extends RxBlocBase
    implements TodoListBlocEvents, TodoListBlocStates, TodoListBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetch]
  final _$fetchEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [toggleCompletion]
  final _$toggleCompletionEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [toggleCompletionAll]
  final _$toggleCompletionAllEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [delete]
  final _$deleteEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [deleteAllCompleted]
  final _$deleteAllCompletedEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [create]
  final _$createEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [filterBy]
  final _$filterByEvent =
      BehaviorSubject<VisibilityFilterModel>.seeded(VisibilityFilterModel.all);

  /// The state of [list] implemented in [_mapToListState]
  late final ReplayConnectableStream<Result<List<TodoEntity>>> _listState =
      _mapToListState();

  /// The state of [allComplete] implemented in [_mapToAllCompleteState]
  late final Stream<bool> _allCompleteState = _mapToAllCompleteState();

  /// The state of [onCompleted] implemented in [_mapToOnCompletedState]
  late final PublishConnectableStream<void> _onCompletedState =
      _mapToOnCompletedState();

  /// The state of [onAllCompletion] implemented in [_mapToOnAllCompletionState]
  late final PublishConnectableStream<void> _onAllCompletionState =
      _mapToOnAllCompletionState();

  /// The state of [onDeleted] implemented in [_mapToOnDeletedState]
  late final PublishConnectableStream<TodoEntity> _onDeletedState =
      _mapToOnDeletedState();

  /// The state of [onCompleteDeleted] implemented in
  /// [_mapToOnCompleteDeletedState]
  late final PublishConnectableStream<void> _onCompleteDeletedState =
      _mapToOnCompleteDeletedState();

  /// The state of [onAdded] implemented in [_mapToOnAddedState]
  late final PublishConnectableStream<TodoEntity> _onAddedState =
      _mapToOnAddedState();

  @override
  void fetch() => _$fetchEvent.add(null);

  @override
  void toggleCompletion(TodoEntity todoEntity) =>
      _$toggleCompletionEvent.add(todoEntity);

  @override
  void toggleCompletionAll() => _$toggleCompletionAllEvent.add(null);

  @override
  void delete(TodoEntity todo) => _$deleteEvent.add(todo);

  @override
  void deleteAllCompleted() => _$deleteAllCompletedEvent.add(null);

  @override
  void create(TodoEntity todo) => _$createEvent.add(todo);

  @override
  void filterBy(VisibilityFilterModel filter) => _$filterByEvent.add(filter);

  @override
  ReplayConnectableStream<Result<List<TodoEntity>>> get list => _listState;

  @override
  Stream<bool> get allComplete => _allCompleteState;

  @override
  PublishConnectableStream<void> get onCompleted => _onCompletedState;

  @override
  PublishConnectableStream<void> get onAllCompletion => _onAllCompletionState;

  @override
  PublishConnectableStream<TodoEntity> get onDeleted => _onDeletedState;

  @override
  PublishConnectableStream<void> get onCompleteDeleted =>
      _onCompleteDeletedState;

  @override
  PublishConnectableStream<TodoEntity> get onAdded => _onAddedState;

  ReplayConnectableStream<Result<List<TodoEntity>>> _mapToListState();

  Stream<bool> _mapToAllCompleteState();

  PublishConnectableStream<void> _mapToOnCompletedState();

  PublishConnectableStream<void> _mapToOnAllCompletionState();

  PublishConnectableStream<TodoEntity> _mapToOnDeletedState();

  PublishConnectableStream<void> _mapToOnCompleteDeletedState();

  PublishConnectableStream<TodoEntity> _mapToOnAddedState();

  @override
  TodoListBlocEvents get events => this;

  @override
  TodoListBlocStates get states => this;

  @override
  void dispose() {
    _$fetchEvent.close();
    _$toggleCompletionEvent.close();
    _$toggleCompletionAllEvent.close();
    _$deleteEvent.close();
    _$deleteAllCompletedEvent.close();
    _$createEvent.close();
    _$filterByEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
