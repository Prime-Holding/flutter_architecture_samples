import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../blocs/home_bloc.dart';

class HomeDependencies {
  HomeDependencies._(this.context);

  factory HomeDependencies.of(BuildContext context) =>
      _instance != null ? _instance! : _instance = HomeDependencies._(context);

  static HomeDependencies? _instance;

  final BuildContext context;

  late List<SingleChildWidget> providers = [
    ..._repositories,
    ..._blocs,

    /// Feature specific services, use cases and utils could be added here
  ];

  late final List<Provider> _repositories = [];

  late final List<RxBlocProvider> _blocs = [
    RxBlocProvider<HomeBlocType>(
      create: (context) => HomeBloc(context.read()),
    ),
  ];
}
