// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'todo_details_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class TodoDetailsBlocType extends RxBlocTypeBase {
  TodoDetailsBlocEvents get events;
  TodoDetailsBlocStates get states;
}

/// [$TodoDetailsBloc] extended by the [TodoDetailsBloc]
/// {@nodoc}
abstract class $TodoDetailsBloc extends RxBlocBase
    implements
        TodoDetailsBlocEvents,
        TodoDetailsBlocStates,
        TodoDetailsBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetchData]
  final _$fetchDataEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [setCompletion]
  final _$setCompletionEvent = PublishSubject<bool>();

  /// Тhe [Subject] where events sink to by calling [delete]
  final _$deleteEvent = PublishSubject<void>();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [todo] implemented in [_mapToTodoState]
  late final Stream<TodoEntity> _todoState = _mapToTodoState();

  /// The state of [completed] implemented in [_mapToCompletedState]
  late final Stream<bool> _completedState = _mapToCompletedState();

  /// The state of [deleted] implemented in [_mapToDeletedState]
  late final Stream<TodoEntity> _deletedState = _mapToDeletedState();

  @override
  void fetchData() => _$fetchDataEvent.add(null);

  @override
  void setCompletion(bool complete) => _$setCompletionEvent.add(complete);

  @override
  void delete() => _$deleteEvent.add(null);

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<TodoEntity> get todo => _todoState;

  @override
  Stream<bool> get completed => _completedState;

  @override
  Stream<TodoEntity> get deleted => _deletedState;

  Stream<String> _mapToErrorsState();

  Stream<TodoEntity> _mapToTodoState();

  Stream<bool> _mapToCompletedState();

  Stream<TodoEntity> _mapToDeletedState();

  @override
  TodoDetailsBlocEvents get events => this;

  @override
  TodoDetailsBlocStates get states => this;

  @override
  void dispose() {
    _$fetchDataEvent.close();
    _$setCompletionEvent.close();
    _$deleteEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
