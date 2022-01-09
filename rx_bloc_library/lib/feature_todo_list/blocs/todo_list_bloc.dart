import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/extensions/todo_entity_extensions.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rx_bloc_library/base/services/todo_list_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'todo_list_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoListBloC.
abstract class TodoListBlocEvents {
  /// Fetch the list of all todos.
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoList]
  void fetch();

  /// Toggle the [TodoEntity.complete] (complete/incomplete) of the given [todoEntity].
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoCompleted]
  void toggleCompletion(TodoEntity todoEntity);

  /// Toggle the completion state of all [TodoEntity].
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoList]
  void toggleCompletionAll();

  /// Delete the give [todo].
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoDeleted]
  void delete(TodoEntity todo);

  /// Delete all completed [TodoEntity] list.
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoList]
  void deleteAllCompleted();

  /// Persist the given [todo].
  ///
  /// Subscribe for state changes in
  /// - [TodoListBlocStates.todoAdded]
  /// - [TodoListBlocStates.todoList]
  void create(TodoEntity todo);

  /// Filter the [TodoListBlocStates.todoList] by the give [filter]
  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: VisibilityFilterModel.all)
  void filterBy(VisibilityFilterModel filter);
}

/// A contract class containing all states of the TodoListBloC.
abstract class TodoListBlocStates {
  /// The state where all errors of the async operations in this bloc
  /// are reported.
  @RxBlocIgnoreState()
  Stream<Exception> get errors;

  /// The state of the all visible todos.
  ///
  /// This state is controlled by
  /// - [TodoListBlocEvents.fetch]
  /// - [TodoListBlocEvents.toggleCompletion]
  /// - [TodoListBlocEvents.delete]
  /// - [TodoListBlocEvents.create]
  /// - [TodoListBlocEvents.filterBy]
  ReplayConnectableStream<Result<List<TodoEntity>>> get list;

  /// The current [TodoEntity] list filter.
  ///
  /// This state is controlled by [TodoListBlocEvents.filterBy]
  @RxBlocIgnoreState()
  Stream<VisibilityFilterModel> get currentFilter;

  /// Check whether each [TodoEntity] of the given [todoList] is complete.
  Stream<bool> get allComplete;

  /// The state of the change of a [TodoEntity]
  ///
  /// This state is controlled by [TodoListBlocEvents.toggleCompletion]
  PublishConnectableStream<void> get onCompleted;

  /// The completion state of the change of all [TodoEntity]
  ///
  /// This state is controlled by [HomeBlocEvents.toggleTodoListCompletion]
  PublishConnectableStream<void> get onAllCompletion;

  /// The state of a successfully deleted [TodoEntity]
  ///
  /// This state is controlled by [TodoListBlocEvents.delete]
  PublishConnectableStream<TodoEntity> get onDeleted;

  /// The state of a successfully deleted completed [TodoEntity] list.
  ///
  /// This state is controlled by [HomeBlocEvents.deleteTodoListCompleted]
  PublishConnectableStream<void> get onCompleteDeleted;

  /// The state of the successfully added [TodoEntity].
  ///
  /// This state is controlled by [TodoListBlocEvents.create]
  PublishConnectableStream<TodoEntity> get onAdded;
}

@RxBloc()
class TodoListBloc extends $TodoListBloc {
  TodoListBloc(
    TodoListService service,
  ) : _service = service {
    onCompleted.connect().addTo(_compositeSubscription);
    onDeleted.connect().addTo(_compositeSubscription);
    onAdded.connect().addTo(_compositeSubscription);
    list.connect().addTo(_compositeSubscription);
    onAllCompletion.connect().addTo(_compositeSubscription);
    onCompleteDeleted.connect().addTo(_compositeSubscription);
  }

  final TodoListService _service;

  @override
  ReplayConnectableStream<Result<List<TodoEntity>>> _mapToListState() =>
      Rx.combineLatest2<Result<List<TodoEntity>>, VisibilityFilterModel,
          Result<List<TodoEntity>>>(
        _$fetchEvent
            .startWith(null)
            .switchMap((_) => _service.todos().asResultStream()),
        _$filterByEvent,
        (todos, filter) => _service.filterResultTodoListBy(todos, filter),
      ).setResultStateHandler(this).publishReplay(maxSize: 1);

  @override
  PublishConnectableStream<void> _mapToOnCompletedState() =>
      _$toggleCompletionEvent
          .switchMap((todo) => _service
              .updateTodo(
                todo.copyWith(complete: !todo.complete),
              )
              .asResultStream())
          .setResultStateHandler(this)
          .whereSuccess()
          .publish();

  @override
  PublishConnectableStream<TodoEntity> _mapToOnDeletedState() => _$deleteEvent
      .switchMap((todo) => _service
          .deleteTodo(
            [todo.id],
          )
          .then((_) => todo)
          .asResultStream())
      .setResultStateHandler(this)
      .whereSuccess()
      .publish();

  @override
  PublishConnectableStream<TodoEntity> _mapToOnAddedState() => _$createEvent
      .switchMap(
        (todo) => _service.addNewTodo(todo).then((_) => todo).asResultStream(),
      )
      .setResultStateHandler(this)
      .whereSuccess()
      .publish();

  @override
  PublishConnectableStream<void> _mapToOnAllCompletionState() =>
      _$toggleCompletionAllEvent
          .switchMap(
            (_) => _service.toggleTodoListCompletion().asResultStream(),
          )
          .setResultStateHandler(this)
          .whereSuccess()
          .mapTo(null)
          .publish();

  @override
  PublishConnectableStream<void> _mapToOnCompleteDeletedState() =>
      _$deleteAllCompletedEvent
          .switchMap(
            (value) => _service.deleteTodoListCompleted().asResultStream(),
          )
          .setResultStateHandler(this)
          .whereSuccess()
          .mapTo(null)
          .publish();

  @override
  Stream<bool> _mapToAllCompleteState() => _service.allTodoListComplete();

  @override
  Stream<VisibilityFilterModel> get currentFilter => _$filterByEvent;

  @override
  Stream<Exception> get errors => errorState;
}
