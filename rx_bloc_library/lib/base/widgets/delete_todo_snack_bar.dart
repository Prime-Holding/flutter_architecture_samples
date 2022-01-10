import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import '../models/models.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class DeleteTodoSnackBar extends SnackBar {
  final ArchSampleLocalizations localizations;

  DeleteTodoSnackBar({
    required TodoEntity todo,
    required VoidCallback onUndo,
    required this.localizations,
    Key? key,
  }) : super(
          key: key,
          content: Text(
            localizations.todoDeleted(todo.task),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: localizations.undo,
            onPressed: onUndo,
          ),
        );
}
