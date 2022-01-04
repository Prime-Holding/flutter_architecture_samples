import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../blocs/todo_manage_bloc.dart';

class TodoManageDependencies {
  TodoManageDependencies._(this.context, this.todoEntity);

  factory TodoManageDependencies.from(
    BuildContext context, {
    TodoEntity? todoEntity,
  }) =>
      TodoManageDependencies._(context, todoEntity);

  final BuildContext context;
  final TodoEntity? todoEntity;

  late List<SingleChildWidget> providers = [
    ..._blocs,
  ];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<TodoManageBlocType>(
      create: (context) => TodoManageBloc(
        context.read(),
        todoEntity: todoEntity,
      ),
    ),
  ];
}
