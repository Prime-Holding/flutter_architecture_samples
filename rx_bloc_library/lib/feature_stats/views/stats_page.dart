import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rx_bloc_library/base/rx_bloc_library_keys.dart';
import 'package:rx_bloc_library/base/widgets/error_panel.dart';
import 'package:rx_bloc_library/base/widgets/error_snackbar_listener.dart';
import 'package:rx_bloc_library/base/widgets/loading_indicator.dart';
import 'package:todos_app_core/todos_app_core.dart';

import '../blocs/stats_bloc.dart';
import '../di/stats_dependencies.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({
    Key? key,
  }) : super(key: key);

  static Widget withDependencies(BuildContext context) => MultiProvider(
        providers: StatsDependencies.of(context).providers,
        child: StatsPage(),
      );

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ErrorSnackBarListener<StatsBlocType>(
            errorState: (bloc) => bloc.states.errors,
          ),
          RxResultBuilder<StatsBlocType, Stats>(
            state: (bloc) => bloc.states.stats,
            buildLoading: (context, bloc) => LoadingIndicator(
              key: RxBlocLibraryKeys.statsLoadingIndicator,
            ),
            buildError: (context, exception, bloc) => ErrorPanel(
              exception: exception,
            ),
            buildSuccess: (context, state, bloc) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      ArchSampleLocalizations.of(context).completedTodos,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      '${state.numCompleted}',
                      key: ArchSampleKeys.statsNumCompleted,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      ArchSampleLocalizations.of(context).activeTodos,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      '${state.numActive}',
                      key: ArchSampleKeys.statsNumActive,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
