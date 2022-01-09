import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/stats_model.dart';
import 'package:rx_bloc_library/feature_stats/blocs/stats_bloc.dart';
import 'stats_bloc_mock.mocks.dart';

@GenerateMocks([
  StatsBlocEvents,
  StatsBlocStates,
  StatsBlocType,
])
StatsBlocType statsBlocMockFactory({
  required Result<StatsModel> stats,
}) {
  final statsBlocMock = MockStatsBlocType();
  final eventsMock = MockStatsBlocEvents();
  final statesMock = MockStatsBlocStates();

  when(statsBlocMock.events).thenReturn(eventsMock);
  when(statsBlocMock.states).thenReturn(statesMock);

  when(statesMock.stats).thenAnswer(
    (_) => Stream.value(stats),
  );

  when(statesMock.errors).thenAnswer(
    (_) => Stream.empty(),
  );

  return statsBlocMock;
}
