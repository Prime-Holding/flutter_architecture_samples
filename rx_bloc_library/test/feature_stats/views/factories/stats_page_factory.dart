import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/stats_model.dart';
import 'package:rx_bloc_library/feature_stats/blocs/stats_bloc.dart';
import 'package:rx_bloc_library/feature_stats/views/stats_page.dart';
import 'package:rx_bloc_library/feature_todo_list/blocs/todo_list_bloc.dart';

import '../../../feature_todo_list/mocks/todo_list_bloc_mock.dart';
import '../../mocks/stats_bloc_mock.dart';

/// wraps a [StatsPage] in a [Provider] of type [StatsBlocType], creating
/// a mocked bloc depending on the values being tested
Widget statsPageFactory({required Result<StatsModel> stats}) => Scaffold(
      body: MultiProvider(
        providers: [
          RxBlocProvider<StatsBlocType>.value(
            value: statsBlocMockFactory(stats: stats),
          ),
        ],
        child: const StatsPage(),
      ),
    );
