import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rx_bloc_library/base/services/todo_list_service.dart';
import 'package:rx_bloc_library/feature_stats/blocs/stats_bloc.dart';
import 'package:rx_bloc_test/rx_bloc_test.dart';
import 'package:test/test.dart';
import '../../stubs.dart';
import 'stats_bloc_test.mocks.dart';

@GenerateMocks([
  TodoListService,
])
void main() {
  late TodoListService serviceMock;

  setUp(() {
    serviceMock = MockTodoListService();
  });

  group('error state', () {
    rxBlocTest<StatsBloc, Exception>(
      'error',
      build: () async {
        when(serviceMock.getStats()).thenAnswer((_) async* {
          throw Stubs.genericModel;
        });

        return StatsBloc(serviceMock);
      },
      act: (bloc) async {
        bloc.states.stats.listen((event) {}, onError: (error) {});
      },
      state: (bloc) => bloc.states.errors,
      expect: [Stubs.genericModel],
    );
  });

  group('stats state', () {
    rxBlocTest<StatsBloc, Result<StatsModel>>(
      'stats success',
      build: () async {
        when(serviceMock.getStats()).thenAnswer(
          (_) => Stream.value(Stubs.stats22),
        );

        return StatsBloc(serviceMock);
      },
      state: (bloc) => bloc.states.stats,
      act: (bloc) async {
        bloc.events.fetchStats();
      },
      expect: <Result<StatsModel>>[
        Result.loading(),
        Result.success(Stubs.stats22),
      ],
    );

    rxBlocTest<StatsBloc, Result<StatsModel>>(
      'stats error',
      build: () async {
        when(serviceMock.getStats()).thenAnswer((_) async* {
          throw 'test';
        });

        return StatsBloc(serviceMock);
      },
      state: (bloc) => bloc.states.stats,
      expect: <Result<StatsModel>>[
        Result.loading(),
        Result.error(Exception('test')),
      ],
    );
  });
}
