import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/extensions/todo_entity_extensions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'todo_list_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoListBloC.
abstract class TodoListBlocEvents {
  void fetchTodos();

  void toggleTodoCompletion(TodoEntity todoEntity);

  void deleteTodo(TodoEntity todo);

  void addTodo(TodoEntity todo);
}

/// A contract class containing all states of the TodoListBloC.
abstract class TodoListBlocStates {
  @RxBlocIgnoreState()
  Stream<Exception> get errors;

  Stream<Result<List<TodoEntity>>> get todoList;

  PublishConnectableStream<void> get todoCompleted;

  PublishConnectableStream<TodoEntity> get todoDeleted;

  PublishConnectableStream<TodoEntity> get todoAdded;
}

@RxBloc()
class TodoListBloc extends $TodoListBloc {
  TodoListBloc(
    ReactiveTodosRepository repository,
  ) : _repository = repository {
    todoCompleted.connect().addTo(_compositeSubscription);
    todoDeleted.connect().addTo(_compositeSubscription);
    todoAdded.connect().addTo(_compositeSubscription);
  }

  final ReactiveTodosRepository _repository;

  @override
  Stream<Result<List<TodoEntity>>> _mapToTodoListState() => _$fetchTodosEvent
      .startWith(null)
      .switchMap(
        (_) => _repository.todos().asResultStream(),
      )
      .setResultStateHandler(this);

  @override
  PublishConnectableStream<void> _mapToTodoCompletedState() =>
      _$toggleTodoCompletionEvent
          .switchMap((todo) => _repository
              .updateTodo(
                todo.copyWith(complete: !todo.complete),
              )
              .asResultStream())
          .setResultStateHandler(this)
          .whereSuccess()
          .publish();

  @override
  PublishConnectableStream<TodoEntity> _mapToTodoDeletedState() =>
      _$deleteTodoEvent
          .switchMap((todo) => _repository
              .deleteTodo(
                [todo.id],
              )
              .then((_) => todo)
              .asResultStream())
          .setResultStateHandler(this)
          .whereSuccess()
          .publish();

  @override
  PublishConnectableStream<TodoEntity> _mapToTodoAddedState() => _$addTodoEvent
      .switchMap(
        (todo) =>
            _repository.addNewTodo(todo).then((_) => todo).asResultStream(),
      )
      .setResultStateHandler(this)
      .whereSuccess()
      .publish();

  @override
  Stream<Exception> get errors => errorState;
}
