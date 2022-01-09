import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rx_bloc_library/base/widgets/error_snackbar_listener.dart';
import 'package:rx_bloc_library/base/widgets/todo_deleted_snackbar_listener.dart';
import 'package:rx_bloc_library/feature_todo_details/views/todo_details_page.dart';
import 'package:rx_bloc_library/base/widgets/widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../blocs/todo_list_bloc.dart';
import '../di/todo_list_dependencies.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ErrorSnackBarListener<TodoListBlocType>(
            errorState: (bloc) => bloc.states.errors,
          ),
          TodoDeletedSnackBarListener<TodoListBlocType>(
            undoCallback: (todo, bloc) => bloc.events.create(todo),
            deletedTodoState: (bloc) => bloc.states.onDeleted,
          ),
          Expanded(child: _buildDataContainer()),
        ],
      );

  Widget _buildDataContainer() =>
      RxResultBuilder<TodoListBlocType, List<TodoEntity>>(
        state: (bloc) => bloc.states.list,
        buildLoading: (ctx, bloc) => LoadingIndicator(),
        buildError: (ctx, error, bloc) => Center(child: Text(error.toString())),
        buildSuccess: (ctx, todos, bloc) => ListView.builder(
          key: ArchSampleKeys.todoList,
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) =>
              _buildTodo(todos[index], bloc, context),
        ),
      );

  TodoItem _buildTodo(
    TodoEntity todo,
    TodoListBlocType bloc,
    BuildContext context,
  ) =>
      TodoItem(
        todo: todo,
        onDismissed: (_) => bloc.events.delete(todo),
        onTap: () async => await Navigator.of(context).push<TodoEntity>(
          MaterialPageRoute(
            builder: (_) => TodoDetailsPage.withDependencies(
              context,
              id: todo.id,
            ),
          ),
        ),
        onCheckboxChanged: (_) => bloc.events.toggleCompletion(todo),
      );
}
