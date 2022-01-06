import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/extensions/todo_entity_extensions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import 'package:collection/collection.dart';
part 'todo_details_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoDetailsBloC.
abstract class TodoDetailsBlocEvents {
  void fetchTodo();

  void setCompletion(bool complete);

  void delete();
}

/// A contract class containing all states of the TodoDetailsBloC.
abstract class TodoDetailsBlocStates {
  @RxBlocIgnoreState()
  Stream<Exception> get errors;

  Stream<TodoEntity> get todo;

  PublishConnectableStream<bool> get completed;

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
  PublishConnectableStream<bool> _mapToCompletedState() => _$setCompletionEvent
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
