import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class TodoListService {
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
