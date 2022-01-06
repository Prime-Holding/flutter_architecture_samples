import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import 'delete_todo_snack_bar.dart';

class TodoDeletedSnackBarListener<B extends RxBlocTypeBase>
    extends StatelessWidget {
  const TodoDeletedSnackBarListener({
    required this.deletedTodoState,
    required this.undoCallback,
    Key? key,
  }) : super(key: key);

  final Stream<TodoEntity> Function(B) deletedTodoState;
  final void Function(TodoEntity, B) undoCallback;

  @override
  Widget build(BuildContext context) => RxBlocListener<B, TodoEntity>(
        state: (bloc) => deletedTodoState(bloc),
        listener: (context, todo) =>
            ScaffoldMessenger.of(context).showSnackBar(DeleteTodoSnackBar(
          key: ArchSampleKeys.snackbar,
          todo: todo!,
          onUndo: () => undoCallback(todo, context.read<B>()),
          localizations: ArchSampleLocalizations.of(context),
        )),
      );
}
