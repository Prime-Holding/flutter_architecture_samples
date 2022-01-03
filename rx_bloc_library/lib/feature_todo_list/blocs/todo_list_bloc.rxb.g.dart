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

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [todoList] implemented in [_mapToTodoListState]
  late final Stream<Result<List<TodoEntity>>> _todoListState =
      _mapToTodoListState();

  @override
  void fetchData() => _$fetchDataEvent.add(null);

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<Result<List<TodoEntity>>> get todoList => _todoListState;

  Stream<String> _mapToErrorsState();

  Stream<Result<List<TodoEntity>>> _mapToTodoListState();

  @override
  TodoListBlocEvents get events => this;

  @override
  TodoListBlocStates get states => this;

  @override
  void dispose() {
    _$fetchDataEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
