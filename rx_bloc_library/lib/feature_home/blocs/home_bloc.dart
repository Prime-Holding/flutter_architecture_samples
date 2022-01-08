// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rx_bloc_library/base/services/todo_list_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'home_bloc.rxb.g.dart';

/// A contract class containing all events of the HomeBloC.
abstract class HomeBlocEvents {
  /// Select the [tap] that needs to be put on screen.
  ///
  /// Subscribe for state changes in [HomeBlocStates.selectedTab]
  void selectTab(AppTab tab);

  /// Delete all completed [TodoEntity] list.
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoList]
  void deleteTodoListCompleted();

  /// Toggle the completion state of all [TodoEntity].
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoList]
  void toggleTodoListCompletion();
}

/// A contract class containing all states of the HomeBloC.
abstract class HomeBlocStates {
  /// The state of the currently selected tab.
  ///
  /// This state is controlled by [HomeBlocEvents.selectTab]
  Stream<AppTab> get selectedTab;

  /// The state of a successfully deleted completed [TodoEntity] list.
  ///
  /// This state is controlled by [HomeBlocEvents.deleteTodoListCompleted]
  PublishConnectableStream<void> get completeTodoListDeleted;

  /// The state of the change of all [TodoEntity]
  ///
  /// This state is controlled by [HomeBlocEvents.toggleTodoListCompletion]
  PublishConnectableStream<void> get todoListCompleted;

  Stream<bool> get allTodoListComplete;
}

@RxBloc()
class HomeBloc extends $HomeBloc {
  HomeBloc(TodoListService service) : _service = service {
    todoListCompleted.connect().addTo(_compositeSubscription);
    completeTodoListDeleted.connect().addTo(_compositeSubscription);
  }

  final TodoListService _service;

  @override
  Stream<AppTab> _mapToSelectedTabState() =>
      _$selectTabEvent.startWith(AppTab.todos);

  @override
  PublishConnectableStream<void> _mapToTodoListCompletedState() =>
      _$toggleTodoListCompletionEvent
          .switchMap(
            (_) => _service.toggleTodoListCompletion().asResultStream(),
          )
          .setResultStateHandler(this)
          .whereSuccess()
          .mapTo(null)
          .publish();

  @override
  PublishConnectableStream<void> _mapToCompleteTodoListDeletedState() =>
      _$deleteTodoListCompletedEvent
          .switchMap(
            (value) => _service.deleteTodoListCompleted().asResultStream(),
          )
          .setResultStateHandler(this)
          .whereSuccess()
          .mapTo(null)
          .publish();

  @override
  Stream<bool> _mapToAllTodoListCompleteState() => _service.todos().map(
        (todos) => _service.allTodoListComplete(todos),
      );
}
