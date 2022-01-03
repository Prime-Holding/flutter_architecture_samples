import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'todo_list_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoListBloC.
abstract class TodoListBlocEvents {
  /// TODO: Document the event
  void fetchData();
}

/// A contract class containing all states of the TodoListBloC.
abstract class TodoListBlocStates {
  /// The error state
  Stream<String> get errors;

  Stream<Result<List<TodoEntity>>> get todoList;
}

@RxBloc()
class TodoListBloc extends $TodoListBloc {
  TodoListBloc(
    ReactiveTodosRepository repository,
  ) : _repository = repository;

  final ReactiveTodosRepository _repository;

  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<Result<List<TodoEntity>>> _mapToTodoListState() =>
      _$fetchDataEvent.startWith(null).switchMap(
            (_) => _repository
                .todos()
                .map((todos) => todos.isEmpty
                    ? [
                        TodoEntity('test', '123', 'note', false),
                        TodoEntity('test', '123', 'note', true),
                      ]
                    : todos)
                .asResultStream(),
          );
}
