import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/extensions/todo_entity_extensions.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class TodoListService {
  TodoListService(ReactiveTodosRepository repository)
      : _repository = repository;

  final ReactiveTodosRepository _repository;

  Future<void> addNewTodo(TodoEntity todo) => _repository.addNewTodo(todo);

  Future<void> deleteTodo(List<String> idList) =>
      _repository.deleteTodo(idList);

  Stream<List<TodoEntity>> todos() => _repository.todos();

  Future<void> updateTodo(TodoEntity todo) => _repository.updateTodo(todo);

  bool allTodoListComplete(List<TodoEntity> todoList) =>
      todoList.every((todo) => todo.complete);

  Future<void> toggleTodoListCompletion() async {
    final todos = await _repository.todos().first;

    final allComplete = allTodoListComplete(todos);

    return Future.wait(todos.map(
      (todo) => _repository.updateTodo(
        todo.copyWith(complete: !allComplete),
      ),
    )).then((value) => null);
  }

  Future<void> deleteTodoListCompleted() async {
    final todos = await _repository.todos().first;

    final completeTodoIds = todos
        .where(
          (todo) => todo.complete,
        )
        .map((todo) => todo.id)
        .toList();

    return _repository.deleteTodo(completeTodoIds);
  }

  Result<List<TodoEntity>> filterResultTodoListBy(
    Result<List<TodoEntity>> todoList,
    VisibilityFilter filter,
  ) {
    if (todoList is ResultSuccess<List<TodoEntity>>) {
      return Result.success(filterTodoListBy(todoList.data, filter));
    }

    return todoList;
  }

  List<TodoEntity> filterTodoListBy(
    List<TodoEntity> todoList,
    VisibilityFilter filter,
  ) =>
      todoList.where((todo) {
        if (filter == VisibilityFilter.all) {
          return true;
        }

        if (filter == VisibilityFilter.active && !todo.complete) {
          return true;
        }

        if (filter == VisibilityFilter.completed && todo.complete) {
          return true;
        }

        return false;
      }).toList();
}
