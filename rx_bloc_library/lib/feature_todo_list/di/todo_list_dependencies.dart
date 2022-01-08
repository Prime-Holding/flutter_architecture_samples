import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';

import 'package:provider/single_child_widget.dart';

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
