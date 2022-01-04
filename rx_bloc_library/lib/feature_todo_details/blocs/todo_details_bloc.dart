import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/extensions/todo_entity_extensions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'todo_details_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoDetailsBloC.
abstract class TodoDetailsBlocEvents {
  /// TODO: Document the event
  void fetchData();

  void setCompletion(bool complete);

  void delete();
}

/// A contract class containing all states of the TodoDetailsBloC.
abstract class TodoDetailsBlocStates {
  /// The error state
  Stream<String> get errors;

  Stream<TodoEntity> get todo;

  Stream<bool> get completed;

  Stream<TodoEntity> get deleted;
}

@RxBloc()
class TodoDetailsBloc extends $TodoDetailsBloc {
  TodoDetailsBloc(
    ReactiveTodosRepository repository, {
    required String id,
  })  : _repository = repository,
        _id = id;

  final ReactiveTodosRepository _repository;
  final String _id;

  /// TODO: Implement error event-to-state logic
  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<TodoEntity> _mapToTodoState() => _$fetchDataEvent
      .startWith(null)
      .switchMap(
        (value) => _repository
            .todos()
            .map((todos) => todos.firstWhere((todo) => todo.id == _id))
            .asResultStream(),
      )
      .setResultStateHandler(this)
      .whereSuccess();

  @override
  Stream<bool> _mapToCompletedState() => _$setCompletionEvent
      .withLatestFrom<TodoEntity, TodoEntity>(
        todo,
        (complete, todo) => todo.copyWith(complete: complete),
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
      .map((todo) => todo.complete);

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
}
