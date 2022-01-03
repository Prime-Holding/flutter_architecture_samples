import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rx_bloc_library/feature_todo_details/views/todo_details_page.dart';
import 'package:rx_bloc_library/widgets/loading_indicator.dart';
import 'package:rx_bloc_library/widgets/widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../blocs/todo_list_bloc.dart';
import '../di/todo_list_dependencies.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({
    Key? key,
  }) : super(key: key);

  static Widget withDepencencies(BuildContext context) => MultiProvider(
        providers: TodoListDependencies.from(context).providers,
        child: TodoListPage(),
      );

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildErrorListener(),
          Expanded(child: _buildDataContainer()),
        ],
      );

  Widget _buildDataContainer() =>
      RxResultBuilder<TodoListBlocType, List<TodoEntity>>(
        state: (bloc) => bloc.states.todoList,
        buildLoading: (ctx, bloc) => LoadingIndicator(),
        buildError: (ctx, error, bloc) => Text(error.toString()),
        buildSuccess: (ctx, todos, bloc) {
          final localizations = ArchSampleLocalizations.of(ctx);

          return ListView.builder(
            key: ArchSampleKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (_) {
                  // todosBloc.add(DeleteTodo(todo));
                  Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                    key: ArchSampleKeys.snackbar,
                    todo: todo,
                    onUndo: () {}, //=>  todosBloc.add(AddTodo(todo)),
                    localizations: localizations,
                  ));
                },
                onTap: () async {
                  final removedTodo =
                      await Navigator.of(context).push<TodoEntity>(
                    MaterialPageRoute(builder: (_) {
                      return TodoDetailsPage.withDependencies(
                        context,
                        id: todo.id,
                      );
                    }),
                  );
                  // if (removedTodo != null) {
                  //   Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                  //     key: ArchSampleKeys.snackbar,
                  //     todo: todo,
                  //     onUndo: () => todosBloc.add(AddTodo(todo)),
                  //     localizations: localizations,
                  //   ));
                  // }
                },
                onCheckboxChanged: (_) {
                  // todosBloc.add(
                  //   UpdateTodo(todo.copyWith(complete: !todo.complete)),
                  // );
                },
              );
            },
          );
        },
      );

  Widget _buildErrorListener() => RxBlocListener<TodoListBlocType, String>(
        state: (bloc) => bloc.states.errors,
        listener: (context, errorMessage) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage ?? ''),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );
}
