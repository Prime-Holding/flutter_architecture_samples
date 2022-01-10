// Mocks generated by Mockito 5.0.17 from annotations
// in rx_bloc_library/test/feature_stats/blocs/stats_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:rx_bloc/rx_bloc.dart' as _i2;
import 'package:rx_bloc_library/base/models/models.dart' as _i6;
import 'package:rx_bloc_library/base/services/todo_list_service.dart' as _i3;
import 'package:todos_repository_core/todos_repository_core.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeResult_0<T> extends _i1.Fake implements _i2.Result<T> {}

/// A class which mocks [TodoListService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoListService extends _i1.Mock implements _i3.TodoListService {
  MockTodoListService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> addNewTodo(_i5.TodoEntity? todo) =>
      (super.noSuchMethod(Invocation.method(#addNewTodo, [todo]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteTodo(List<String>? idList) =>
      (super.noSuchMethod(Invocation.method(#deleteTodo, [idList]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> updateTodo(_i5.TodoEntity? todo) =>
      (super.noSuchMethod(Invocation.method(#updateTodo, [todo]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Stream<List<_i5.TodoEntity>> todos() =>
      (super.noSuchMethod(Invocation.method(#todos, []),
              returnValue: Stream<List<_i5.TodoEntity>>.empty())
          as _i4.Stream<List<_i5.TodoEntity>>);
  @override
  _i4.Stream<bool> allTodoListComplete() =>
      (super.noSuchMethod(Invocation.method(#allTodoListComplete, []),
          returnValue: Stream<bool>.empty()) as _i4.Stream<bool>);
  @override
  _i4.Future<void> toggleTodoListCompletion() =>
      (super.noSuchMethod(Invocation.method(#toggleTodoListCompletion, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> deleteTodoListCompleted() =>
      (super.noSuchMethod(Invocation.method(#deleteTodoListCompleted, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i2.Result<List<_i5.TodoEntity>> filterResultTodoListBy(
          _i2.Result<List<_i5.TodoEntity>>? todoList,
          _i6.VisibilityFilterModel? filter) =>
      (super.noSuchMethod(
              Invocation.method(#filterResultTodoListBy, [todoList, filter]),
              returnValue: _FakeResult_0<List<_i5.TodoEntity>>())
          as _i2.Result<List<_i5.TodoEntity>>);
  @override
  _i4.Stream<_i6.StatsModel> getStats() =>
      (super.noSuchMethod(Invocation.method(#getStats, []),
              returnValue: Stream<_i6.StatsModel>.empty())
          as _i4.Stream<_i6.StatsModel>);
  @override
  List<_i5.TodoEntity> filterTodoListBy(
          List<_i5.TodoEntity>? todoList, _i6.VisibilityFilterModel? filter) =>
      (super.noSuchMethod(
          Invocation.method(#filterTodoListBy, [todoList, filter]),
          returnValue: <_i5.TodoEntity>[]) as List<_i5.TodoEntity>);
}
