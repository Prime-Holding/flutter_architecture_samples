import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../blocs/todo_details_bloc.dart';

class TodoDetailsDependencies {
  TodoDetailsDependencies._(this.context, this.id);

  factory TodoDetailsDependencies.from(
    BuildContext context, {
    required String id,
  }) =>
      TodoDetailsDependencies._(context, id);

  final BuildContext context;
  final String id;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._blocs,
  ];

  late final List<Provider> _repositories = [];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<TodoDetailsBlocType>(
      create: (context) => TodoDetailsBloc(
        context.read(),
        id: id,
      ),
    ),
  ];
}
