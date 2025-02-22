import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rx_bloc_library/base/services/todo_list_service.dart';
import 'package:rxdart/rxdart.dart';

part 'stats_bloc.rxb.g.dart';

/// A contract class containing all events of the StatsBloC.
abstract class StatsBlocEvents {
  /// Fetch the todo stats.
  ///
  /// Subscribe for state changes in [StatsBlocStates.stats]
  void fetchStats();
}

/// A contract class containing all states of the StatsBloC.
abstract class StatsBlocStates {
  /// The state where all errors of the async operations in this bloc
  /// are reported.
  @RxBlocIgnoreState()
  Stream<Exception> get errors;

  /// The state of the todo stats.
  ///
  /// This state is refreshed by [StatsBlocEvents.fetchStats]
  Stream<Result<StatsModel>> get stats;
}

@RxBloc()
class StatsBloc extends $StatsBloc {
  StatsBloc(TodoListService service) : _service = service;

  final TodoListService _service;

  @override
  Stream<Result<StatsModel>> _mapToStatsState() => _$fetchStatsEvent
      .startWith(null)
      .throttleTime(Duration(seconds: 1))
      .switchMap(
        (value) => _service.getStats().asResultStream(),
      )
      .setResultStateHandler(this);

  @override
  Stream<Exception> get errors => errorState;
}
