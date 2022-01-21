import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rx_bloc_library/base/services/todo_list_service.dart';
import 'package:rx_bloc_library/feature_todo_list/blocs/todo_list_bloc.dart';
import 'package:rx_bloc_test/rx_bloc_test.dart';
import 'package:test/test.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import '../../stubs.dart';
import 'todo_list_bloc_test.mocks.dart';

@GenerateMocks([
  ReactiveTodosRepository,
])
void main() {
  late ReactiveTodosRepository repositoryMock;

  setUp(() {
    repositoryMock = MockReactiveTodosRepository();
  });

  group('on completed state', () {
    rxBlocTest<TodoListBloc, void>(
      'on completed - success',
      build: () async => _blocFactory(repositoryMock),
      act: (bloc) async {
        bloc.events.toggleCompletion(Stubs.todoActive);
      },
      state: (bloc) => bloc.states.onCompleted,
      expect: [null],
    );
  });

  group('on deleted state', () {
    rxBlocTest<TodoListBloc, void>(
      'on deleted - success',
      build: () async => _blocFactory(repositoryMock),
      act: (bloc) async {
        bloc.events.delete(Stubs.todoActive);
      },
      state: (bloc) => bloc.states.onDeleted,
      expect: [Stubs.todoActive],
    );
  });

  group('on added state', () {
    rxBlocTest<TodoListBloc, void>(
      'on added - success',
      build: () async => _blocFactory(repositoryMock),
      act: (bloc) async {
        bloc.events.create(Stubs.todoActive);
      },
      state: (bloc) => bloc.states.onAdded,
      expect: [Stubs.todoActive],
    );
  });

  group('on all completion state', () {
    rxBlocTest<TodoListBloc, void>(
      'on all completion- success',
      build: () async {
        when(repositoryMock.todos()).thenAnswer(
          (_) => Stream.value(Stubs.todosActive2Completed3),
        );

        return _blocFactory(repositoryMock);
      },
      act: (bloc) async {
        bloc.events.toggleCompletionAll();
      },
      state: (bloc) => bloc.states.onAllCompletion,
      expect: [null],
    );
  });

  group('on complete deleted state', () {
    rxBlocTest<TodoListBloc, void>(
      'on complete deleted - success',
      build: () async {
        when(repositoryMock.todos()).thenAnswer(
          (_) => Stream.value(Stubs.todosActive2Completed3),
        );

        return _blocFactory(repositoryMock);
      },
      act: (bloc) async {
        bloc.events.deleteAllCompleted();
      },
      state: (bloc) => bloc.states.onCompleteDeleted,
      expect: [null],
    );
  });

  group('all complete state', () {
    rxBlocTest<TodoListBloc, bool>(
      'all complete success',
      build: () async {
        when(repositoryMock.todos()).thenAnswer(
          (_) => Stream.fromIterable([
            Stubs.todosActive2Completed3,
            Stubs.todosCompleted,
          ]),
        );

        return _blocFactory(repositoryMock);
      },
      state: (bloc) => bloc.states.allComplete,
      expect: [false, true],
    );
  });

  group('current filter state', () {
    rxBlocTest<TodoListBloc, VisibilityFilterModel>(
      'current filter success',
      build: () async => _blocFactory(repositoryMock),
      act: (bloc) async {
        bloc.events.filterBy(VisibilityFilterModel.completed);
      },
      state: (bloc) => bloc.states.currentFilter,
      expect: [
        VisibilityFilterModel.all,
        VisibilityFilterModel.completed,
      ],
    );
  });

  group('list state', () {
    rxBlocTest<TodoListBloc, Result<List<TodoEntity>>>(
      'stats success',
      build: () async {
        when(repositoryMock.todos()).thenAnswer(
          (_) => Stream.value(Stubs.todosActive2Completed3),
        );

        return _blocFactory(repositoryMock);
      },
      state: (bloc) => bloc.states.list,
      act: (bloc) async {
        bloc.events.filterBy(VisibilityFilterModel.active);
        bloc.events.filterBy(VisibilityFilterModel.completed);
        bloc.events.filterBy(VisibilityFilterModel.all);
      },
      expect: <Result<List<TodoEntity>>>[
        Result.loading(),
        Result.success(Stubs.todosActive2Completed3),
        Result.success(Stubs.todosActive),
        Result.success(Stubs.todosCompleted),
        Result.success(Stubs.todosActive2Completed3),
      ],
    );
  });
}

TodoListBloc _blocFactory(ReactiveTodosRepository repositoryMock) =>
    TodoListBloc(
      TodoListService(repositoryMock),
    );
