import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../blocs/stats_bloc.dart';

class StatsDependencies {
  StatsDependencies._(this.context);

  factory StatsDependencies.of(BuildContext context) =>
      _instance != null ? _instance! : _instance = StatsDependencies._(context);

  static StatsDependencies? _instance;

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._blocs,
  ];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<StatsBlocType>(
      create: (context) => StatsBloc(context.read()),
    ),
  ];
}
