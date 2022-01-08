import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/extensions/todo_entity_extensions.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class TodoListService {
  TodoListService(ReactiveTodosRepository repository)
      : _repository = repository;

  final ReactiveTodosRepository _repository;

  /// Persist the given [todo].
  ///
  /// All subscribers of [TodoListService.todos] will receive the created entity.
  Future<void> addNewTodo(TodoEntity todo) => _repository.addNewTodo(todo);

  /// Delete todos of the given [idList]
  ///
  /// All subscribers of [TodoListService.todos] will receive
  /// a new list without the deleted todos
  Future<void> deleteTodo(List<String> idList) =>
      _repository.deleteTodo(idList);

  /// Update the given [todo].
  ///
  /// All subscribers of [TodoListService.todos] will receive the updated entity.
  Future<void> updateTodo(TodoEntity todo) => _repository.updateTodo(todo);

  /// Get [TodoEntity] list.
  ///
  /// This stream is controlled by
  /// - [TodoListService.addNewTodo]
  /// - [TodoListService.deleteTodo]
  /// - [TodoListService.updateTodo]
  Stream<List<TodoEntity>> todos() => _repository.todos();

  /// Check whether each [TodoEntity] of the given [todoList] are complete.
  bool allTodoListComplete(List<TodoEntity> todoList) =>
      todoList.every((todo) => todo.complete);

  /// Update all the complete field of each [TodoEntity].
  ///
  /// If each [TodoEntity] is complete, they will be updated as uncompleted.
  Future<void> toggleTodoListCompletion() async {
    final todos = await _repository.todos().first;

    final allComplete = allTodoListComplete(todos);

    return Future.wait(todos.map(
      (todo) => _repository.updateTodo(
        todo.copyWith(complete: !allComplete),
      ),
    )).then((value) => null);
  }

  /// Delete each completed of [TodoEntity]
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

  /// Filter the [todoList] by the given [filter]
  Result<List<TodoEntity>> filterResultTodoListBy(
    Result<List<TodoEntity>> todoList,
    VisibilityFilterModel filter,
  ) {
    if (todoList is ResultSuccess<List<TodoEntity>>) {
      return Result.success(filterTodoListBy(todoList.data, filter));
    }

    return todoList;
  }

  /// Filter the [todoList] by the given [filter]
  List<TodoEntity> filterTodoListBy(
    List<TodoEntity> todoList,
    VisibilityFilterModel filter,
  ) =>
      todoList.where((todo) {
        if (filter == VisibilityFilterModel.all) {
          return true;
        }

        if (filter == VisibilityFilterModel.active && !todo.complete) {
          return true;
        }

        if (filter == VisibilityFilterModel.completed && todo.complete) {
          return true;
        }

        return false;
      }).toList();
}
