import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'stats_bloc.rxb.g.dart';

/// A contract class containing all events of the StatsBloC.
abstract class StatsBlocEvents {
  /// TODO: Document the event
  void fetchData();
}

/// A contract class containing all states of the StatsBloC.
abstract class StatsBlocStates {
  /// The error state
  Stream<String> get errors;

  Stream<Result<Stats>> get stats;
}

@RxBloc()
class StatsBloc extends $StatsBloc {
  StatsBloc(ReactiveTodosRepository repository) : _repository = repository;

  final ReactiveTodosRepository _repository;

  /// TODO: Implement error event-to-state logic
  @override
  Stream<String> _mapToErrorsState() =>
      errorState.map((error) => error.toString());

  @override
  Stream<Result<Stats>> _mapToStatsState() => _$fetchDataEvent
      .startWith(null)
      .switchMap(
        (value) => _repository
            .todos()
            .map(
              (list) => Stats(
                numActive: list.where((element) => !element.complete).length,
                numCompleted: list.where((element) => element.complete).length,
              ),
            )
            .asResultStream(),
      );
}
