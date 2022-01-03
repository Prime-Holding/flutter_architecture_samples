import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../blocs/todo_manage_bloc.dart';

class TodoManageDependencies {
  TodoManageDependencies._(this.context);

  factory TodoManageDependencies.of(BuildContext context) => _instance != null
      ? _instance!
      : _instance = TodoManageDependencies._(context);

  static TodoManageDependencies? _instance;

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._blocs,
  ];

  late final List<Provider> _repositories = [];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<TodoManageBlocType>(
      create: (context) => TodoManageBloc(),
    ),
  ];
}
