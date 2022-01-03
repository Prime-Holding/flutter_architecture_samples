import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../blocs/todo_details_bloc.dart';

class TodoDetailsDependencies {
  TodoDetailsDependencies._(this.context);

  factory TodoDetailsDependencies.of(BuildContext context) => _instance != null
      ? _instance!
      : _instance = TodoDetailsDependencies._(context);

  static TodoDetailsDependencies? _instance;

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._blocs,
  ];

  late final List<Provider> _repositories = [];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<TodoDetailsBlocType>(
      create: (context) => TodoDetailsBloc(),
    ),
  ];
}
