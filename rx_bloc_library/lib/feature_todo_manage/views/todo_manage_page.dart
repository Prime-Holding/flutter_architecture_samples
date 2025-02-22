import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:flutter_rx_bloc/rx_form.dart';
import 'package:provider/provider.dart';
import 'package:rx_bloc_library/base/extensions/stream_translate_field_exception.dart';
import 'package:rx_bloc_library/base/widgets/error_snackbar_listener.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../blocs/todo_manage_bloc.dart';
import '../di/todo_manage_dependencies.dart';

class TodoManagePage extends StatelessWidget {
  const TodoManagePage({
    required this.isEditing,
    Key? key,
  }) : super(key: key);

  final bool isEditing;

  static Widget withDependencies(
    BuildContext context, {
    TodoEntity? todoEntity,
    Key? key,
  }) =>
      MultiProvider(
        providers: TodoManageDependencies.from(
          context,
          todoEntity: todoEntity,
        ).providers,
        child: TodoManagePage(
          key: key,
          isEditing: todoEntity != null,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editTodo : localizations.addTodo,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ErrorSnackBarListener<TodoManageBlocType>(
              errorState: (bloc) => bloc.states.errors,
            ),
            _TodoSavedListener(),
            RxTextFormFieldBuilder<TodoManageBlocType>(
              state: (bloc) => bloc.states.task.translateErrors(context),
              showErrorState: (bloc) => bloc.states.errorVisible,
              onChanged: (bloc, value) => bloc.events.setTask(value),
              builder: (fieldState) => TextFormField(
                key: ArchSampleKeys.taskField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: fieldState.decoration.copyWith(
                  hintText: localizations.newTodoHint,
                ),
                controller: fieldState.controller,
              ),
            ),
            RxTextFormFieldBuilder<TodoManageBlocType>(
              state: (bloc) => bloc.states.note,
              showErrorState: (bloc) => Stream.empty(),
              onChanged: (bloc, value) => bloc.events.setNote(value),
              builder: (fieldState) => TextFormField(
                key: ArchSampleKeys.noteField,
                maxLines: 10,
                style: textTheme.subtitle2,
                decoration: fieldState.decoration.copyWith(
                  hintText: localizations.notesHint,
                ),
                controller: fieldState.controller,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: TodoSaveButton(
        isEditing: isEditing,
      ),
    );
  }
}

class TodoSaveButton extends StatelessWidget {
  const TodoSaveButton({
    Key? key,
    required this.isEditing,
  }) : super(key: key);

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    return FloatingActionButton(
      key: isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
      tooltip: isEditing ? localizations.saveChanges : localizations.addTodo,
      child: Icon(isEditing ? Icons.check : Icons.add),
      onPressed: () => context.read<TodoManageBlocType>().events.save(),
    );
  }
}

class _TodoSavedListener extends StatelessWidget {
  const _TodoSavedListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      RxBlocListener<TodoManageBlocType, TodoEntity>(
        state: (bloc) => bloc.states.onSaved,
        listener: (context, todoEntity) => Navigator.of(context).pop(),
      );
}
