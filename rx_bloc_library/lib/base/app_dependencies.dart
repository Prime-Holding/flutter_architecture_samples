import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:todos_repository_local_storage/todos_repository_local_storage.dart';

import '../feature_todo_list/blocs/todo_list_bloc.dart';
import '../feature_todo_list/services/todo_list_service.dart';

class AppDependencies {
  AppDependencies._(this.context);

  factory AppDependencies.from(BuildContext context) =>
      AppDependencies._(context);

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._services,
    ..._blocs,
  ];

  late final List<SingleChildWidget> _repositories = [
    Provider<ReactiveTodosRepository>(
      create: (context) => ReactiveLocalStorageRepository(
        seedValue: [
          TodoEntity('test 1', '1', 'note 1', false),
          TodoEntity('test 2', '2', 'note 2', true),
        ],
        repository: KeyValueStorage(
          'rx_bloc_library',
          SharedPreferences.getInstance(),
        ),
      ),
    )
  ];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<TodoListBlocType>(
      create: (context) => TodoListBloc(
        context.read(),
        context.read(),
      ),
    ),
  ];

  late final List<SingleChildWidget> _services = [
    Provider<TodoListService>(
      create: (context) => TodoListService(),
    ),
  ];
}
