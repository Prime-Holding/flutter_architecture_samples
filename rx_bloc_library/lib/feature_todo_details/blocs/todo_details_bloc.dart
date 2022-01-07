import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/extensions/todo_entity_extensions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import 'package:collection/collection.dart';
part 'todo_details_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoDetailsBloC.
abstract class TodoDetailsBlocEvents {
  /// Fetch the current todo.
  ///
  /// Subscribe for state changes in [TodoDetailsBlocStates.todo]
  void fetchTodo();

  /// Toggle the [TodoEntity.complete] (complete/incomplete) of the current todo.
  ///
  /// Subscribe for state changes in [TodoDetailsBlocStates.completed]
  void toggleCompletion();

  /// Delete the current todo.
  ///
  /// Subscribe for state changes in [TodoDetailsBlocStates.deleted]
  void delete();
}

/// A contract class containing all states of the TodoDetailsBloC.
abstract class TodoDetailsBlocStates {
  /// The state where all errors of the async operations in this bloc
  /// are reported.
  @RxBlocIgnoreState()
  Stream<Exception> get errors;

  /// The state of the current todo.
  ///
  /// This state is controlled by
  ///  - [TodoDetailsBlocEvents.fetchTodo]
  ///  - [TodoDetailsBlocEvents.toggleCompletion]
  Stream<TodoEntity> get todo;

  /// The state of the change of the current todo.
  ///
  /// This state is controlled by [TodoDetailsBlocEvents.toggleCompletion]
  PublishConnectableStream<bool> get completed;

  /// The state of the deletion success of the current todo.
  ///
  /// This state is controlled by the [TodoDetailsBlocEvents.delete]
  Stream<TodoEntity> get deleted;
}

@RxBloc()
class TodoDetailsBloc extends $TodoDetailsBloc {
  TodoDetailsBloc(
    ReactiveTodosRepository repository, {
    required String id,
  })  : _repository = repository,
        _id = id {
    completed.connect().addTo(_compositeSubscription);
  }

  final ReactiveTodosRepository _repository;
  final String _id;

  @override
  Stream<TodoEntity> _mapToTodoState() => _$fetchTodoEvent
      .startWith(null)
      .switchMap(
        (value) => _repository
            .todos()
            .map((todos) => todos.firstWhereOrNull((todo) => todo.id == _id))
            .whereType<TodoEntity>()
            .asResultStream(),
      )
      .setResultStateHandler(this)
      .whereSuccess();

  @override
  PublishConnectableStream<bool> _mapToCompletedState() =>
      _$toggleCompletionEvent
          .withLatestFrom<TodoEntity, TodoEntity>(
            todo,
            (complete, todo) => todo.copyWith(complete: !todo.complete),
          )
          .switchMap(
            (todo) => _repository
                .updateTodo(todo)
                .asStream()
                .mapTo(todo)
                .asResultStream(),
          )
          .setResultStateHandler(this)
          .whereSuccess()
          .map((todo) => todo.complete)
          .publish();

  @override
  Stream<TodoEntity> _mapToDeletedState() => _$deleteEvent
      .withLatestFrom<TodoEntity, TodoEntity>(
        todo,
        (complete, todo) => todo,
      )
      .switchMap(
        (todo) => _repository
            .deleteTodo([todo.id])
            .asStream()
            .mapTo(todo)
            .asResultStream(),
      )
      .setResultStateHandler(this)
      .whereSuccess();

  @override
  Stream<Exception> get errors => errorState;
}
