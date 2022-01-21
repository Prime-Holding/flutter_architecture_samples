import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rx_bloc_library/base/services/todo_list_service.dart';
import 'package:rx_bloc_library/feature_stats/blocs/stats_bloc.dart';
import 'package:rx_bloc_test/rx_bloc_test.dart';
import 'package:test/test.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import '../../stubs.dart';
import 'stats_bloc_test.mocks.dart';

@GenerateMocks([
  ReactiveTodosRepository,
])
void main() {
  late ReactiveTodosRepository repositoryMock;

  setUp(() {
    repositoryMock = MockReactiveTodosRepository();
  });

  group('StatsBloc error state', () {
    rxBlocTest<StatsBloc, Exception>(
      'error state',
      build: () async {
        when(repositoryMock.todos()).thenAnswer((_) async* {
          throw Stubs.genericModel;
        });

        return _blocFactory(repositoryMock);
      },
      act: (bloc) async {
        bloc.states.stats.listen((event) {}, onError: (error) {});
      },
      state: (bloc) => bloc.states.errors,
      expect: [Stubs.genericModel],
    );
  });

  group('StatsBloc state', () {
    rxBlocTest<StatsBloc, Result<StatsModel>>(
      'stats success',
      build: () async {
        when(repositoryMock.todos()).thenAnswer(
          (_) => Stream.value(Stubs.todosActive2Completed3),
        );

        return _blocFactory(repositoryMock);
      },
      state: (bloc) => bloc.states.stats,
      act: (bloc) async {
        bloc.events.fetchStats();
      },
      expect: <Result<StatsModel>>[
        Result.loading(),
        Result.success(Stubs.statsActive2Completed3),
      ],
    );

    rxBlocTest<StatsBloc, Result<StatsModel>>(
      'stats error',
      build: () async {
        when(repositoryMock.todos()).thenAnswer((_) async* {
          throw Stubs.genericModel;
        });

        return _blocFactory(repositoryMock);
      },
      state: (bloc) => bloc.states.stats,
      expect: <Result<StatsModel>>[
        Result.loading(),
        Result.error(Stubs.genericModel),
      ],
    );
  });
}

StatsBloc _blocFactory(ReactiveTodosRepository repositoryMock) => StatsBloc(
      TodoListService(repositoryMock),
    );
