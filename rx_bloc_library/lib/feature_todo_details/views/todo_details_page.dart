import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rx_bloc_library/feature_todo_manage/views/todo_manage_page.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../base/rx_bloc_library_keys.dart';
import '../blocs/todo_details_bloc.dart';
import '../di/todo_details_dependencies.dart';

class TodoDetailsPage extends StatelessWidget {
  const TodoDetailsPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

  static Widget withDependencies(
    BuildContext context, {
    required String id,
  }) =>
      MultiProvider(
        providers: TodoDetailsDependencies.from(context, id: id).providers,
        child: TodoDetailsPage(id: id),
      );

  @override
  Widget build(BuildContext context) => Row(
        children: [
          _buildErrorListener(),
          _buildCompletedListener(),
          _buildDeletedListener(),
          Expanded(
            child: RxBlocBuilder<TodoDetailsBlocType, TodoEntity>(
              state: (bloc) => bloc.states.todo,
              builder: (context, state, bloc) {
                final todo = state.data;
                final localizations = ArchSampleLocalizations.of(context);

                return Scaffold(
                  appBar: AppBar(
                    title: Text(localizations.todoDetails),
                    actions: [
                      IconButton(
                        tooltip: localizations.deleteTodo,
                        key: ArchSampleKeys.deleteTodoButton,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          bloc.events.delete();
                        },
                      )
                    ],
                  ),
                  body: todo == null
                      ? Container(key: RxBlocLibraryKeys.emptyDetailsContainer)
                      : Padding(
                          padding: EdgeInsets.all(16.0),
                          child: ListView(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Checkbox(
                                      key: RxBlocLibraryKeys
                                          .detailsScreenCheckBox,
                                      value: todo.complete,
                                      onChanged: (_) => bloc.events
                                          .setCompletion(!todo.complete),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Hero(
                                          tag: '${todo.id}__heroTag',
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 16.0,
                                            ),
                                            child: Text(
                                              todo.task,
                                              key: ArchSampleKeys
                                                  .detailsTodoItemTask,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          todo.note,
                                          key: ArchSampleKeys
                                              .detailsTodoItemNote,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  floatingActionButton: FloatingActionButton(
                    key: ArchSampleKeys.editTodoFab,
                    tooltip: localizations.editTodo,
                    child: Icon(Icons.edit),
                    onPressed: todo == null
                        ? null
                        : () {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute(
                                builder: (context) {
                                  return TodoManagePage.withDependencies(
                                    context,
                                    key: ArchSampleKeys.editTodoScreen,
                                    todoEntity: todo,
                                    // onSave: (task, note) {
                                    //   todosBloc.add(
                                    //     UpdateTodo(
                                    //       todo.copyWith(task: task, note: note),
                                    //     ),
                                    //   );
                                    // },
                                    // isEditing: true,
                                    // todo: todo,
                                  );
                                },
                              ),
                            );
                          },
                  ),
                );
              },
            ),
          ),
        ],
      );

  Widget _buildErrorListener() => RxBlocListener<TodoDetailsBlocType, String>(
        state: (bloc) => bloc.states.errors,
        listener: (context, errorMessage) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage ?? ''),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );

  Widget _buildCompletedListener() => RxBlocListener<TodoDetailsBlocType, bool>(
        state: (bloc) => bloc.states.completed,
        listener: (context, errorMessage) {},
      );

  Widget _buildDeletedListener() =>
      RxBlocListener<TodoDetailsBlocType, TodoEntity>(
        state: (bloc) => bloc.states.deleted,
        listener: (context, todo) {
          Navigator.pop(context, todo);
        },
      );
}
