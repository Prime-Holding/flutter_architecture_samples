import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rx_bloc_library/base/widgets/error_snackbar_listener.dart';
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(ArchSampleLocalizations.of(context).todoDetails),
          actions: [
            IconButton(
              tooltip: ArchSampleLocalizations.of(context).deleteTodo,
              key: ArchSampleKeys.deleteTodoButton,
              icon: Icon(Icons.delete),
              onPressed: () =>
                  context.read<TodoDetailsBlocType>().events.delete(),
            )
          ],
        ),
        body: Row(
          children: [
            ErrorSnackBarListener<TodoDetailsBlocType>(
              errorState: (bloc) => bloc.states.errors,
            ),
            TodoDeletedListener(),
            Expanded(
              child: RxBlocBuilder<TodoDetailsBlocType, TodoEntity>(
                state: (bloc) => bloc.states.todo,
                builder: (context, state, bloc) =>
                    _buildBody(state.data, bloc, context),
              ),
            ),
          ],
        ),
        floatingActionButton: TodoEditButton(),
      );

  Widget _buildBody(
    TodoEntity? todo,
    TodoDetailsBlocType bloc,
    BuildContext context,
  ) {
    return todo == null
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
                        key: RxBlocLibraryKeys.detailsScreenCheckBox,
                        value: todo.complete,
                        onChanged: (_) =>
                            bloc.events.setCompletion(!todo.complete),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: '${todo.id}__heroTag',
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 16.0,
                              ),
                              child: Text(
                                todo.task,
                                key: ArchSampleKeys.detailsTodoItemTask,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                          Text(
                            todo.note,
                            key: ArchSampleKeys.detailsTodoItemNote,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}

class TodoEditButton extends StatelessWidget {
  const TodoEditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      RxBlocBuilder<TodoDetailsBlocType, TodoEntity>(
        state: (bloc) => bloc.states.todo,
        builder: (context, snapshot, bloc) => FloatingActionButton(
          key: ArchSampleKeys.editTodoFab,
          tooltip: ArchSampleLocalizations.of(context).editTodo,
          child: Icon(Icons.edit),
          onPressed: () => _onEditPressed(snapshot, context),
        ),
      );

  void _onEditPressed(AsyncSnapshot<TodoEntity> todo, BuildContext context) {
    if (todo.hasData) {
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => TodoManagePage.withDependencies(
            context,
            key: ArchSampleKeys.editTodoScreen,
            todoEntity: todo.data,
          ),
        ),
      );
    }
  }
}

class TodoDeletedListener extends StatelessWidget {
  const TodoDeletedListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      RxBlocListener<TodoDetailsBlocType, TodoEntity>(
        state: (bloc) => bloc.states.deleted,
        listener: (context, todo) {
          Navigator.pop(context, todo);
        },
      );
}
