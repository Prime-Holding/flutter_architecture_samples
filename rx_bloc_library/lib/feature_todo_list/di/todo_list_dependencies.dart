import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rx_bloc_library/feature_todo_list/services/todo_list_service.dart';

import '../blocs/todo_list_bloc.dart';

class TodoListDependencies {
  TodoListDependencies._(this.context);

  factory TodoListDependencies.from(BuildContext context) =>
      TodoListDependencies._(context);

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._blocs,
  ];

  late final List<RxBlocProvider> _blocs = [];
}
