import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/stats_model.dart';
import 'package:rx_bloc_library/feature_stats/blocs/stats_bloc.dart';
import 'package:rx_bloc_library/feature_todo_list/blocs/todo_list_bloc.dart';
import 'todo_list_bloc_mock.mocks.dart';

@GenerateMocks([
  TodoListBlocEvents,
  TodoListBlocStates,
  TodoListBlocType,
])
TodoListBlocType todoListBlocMockFactory() {
  final todoListBloc = MockTodoListBlocType();
  final eventsMock = MockTodoListBlocEvents();
  final statesMock = MockTodoListBlocStates();

  when(todoListBloc.events).thenReturn(eventsMock);
  when(todoListBloc.states).thenReturn(statesMock);

  // when(statesMock.stats).thenAnswer(
  //   (_) => Stream.value(stats),
  // );

  return todoListBloc;
}
