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

  /// Тhe [Subject] where events sink to by calling [fetchData]
  final _$fetchDataEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [toggleCompletion]
  final _$toggleCompletionEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [delete]
  final _$deleteEvent = PublishSubject<TodoEntity>();

  /// Тhe [Subject] where events sink to by calling [add]
  final _$addEvent = PublishSubject<TodoEntity>();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [todoList] implemented in [_mapToTodoListState]
  late final Stream<Result<List<TodoEntity>>> _todoListState =
      _mapToTodoListState();

  /// The state of [todoCompleted] implemented in [_mapToTodoCompletedState]
  late final PublishConnectableStream<void> _todoCompletedState =
      _mapToTodoCompletedState();

  /// The state of [todoDeleted] implemented in [_mapToTodoDeletedState]
  late final PublishConnectableStream<TodoEntity> _todoDeletedState =
      _mapToTodoDeletedState();

  /// The state of [todoAdded] implemented in [_mapToTodoAddedState]
  late final PublishConnectableStream<TodoEntity> _todoAddedState =
      _mapToTodoAddedState();

  @override
  void fetchData() => _$fetchDataEvent.add(null);

  @override
  void toggleCompletion(TodoEntity todoEntity) =>
      _$toggleCompletionEvent.add(todoEntity);

  @override
  void delete(TodoEntity todo) => _$deleteEvent.add(todo);

  @override
  void add(TodoEntity todo) => _$addEvent.add(todo);

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<Result<List<TodoEntity>>> get todoList => _todoListState;

  @override
  PublishConnectableStream<void> get todoCompleted => _todoCompletedState;

  @override
  PublishConnectableStream<TodoEntity> get todoDeleted => _todoDeletedState;

  @override
  PublishConnectableStream<TodoEntity> get todoAdded => _todoAddedState;

  Stream<String> _mapToErrorsState();

  Stream<Result<List<TodoEntity>>> _mapToTodoListState();

  PublishConnectableStream<void> _mapToTodoCompletedState();

  PublishConnectableStream<TodoEntity> _mapToTodoDeletedState();

  PublishConnectableStream<TodoEntity> _mapToTodoAddedState();

  @override
  TodoListBlocEvents get events => this;

  @override
  TodoListBlocStates get states => this;

  @override
  void dispose() {
    _$fetchDataEvent.close();
    _$toggleCompletionEvent.close();
    _$deleteEvent.close();
    _$addEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
