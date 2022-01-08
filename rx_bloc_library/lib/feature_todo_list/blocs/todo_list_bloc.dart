import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/extensions/todo_entity_extensions.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rx_bloc_library/feature_todo_list/services/todo_list_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'todo_list_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoListBloC.
abstract class TodoListBlocEvents {
  /// Fetch the list of all todos.
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoList]
  void fetchTodos();

  /// Toggle the [TodoEntity.complete] (complete/incomplete) of the given [todoEntity].
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoCompleted]
  void toggleTodoCompletion(TodoEntity todoEntity);

  /// Delete the give [todo].
  ///
  /// Subscribe for state changes in [TodoListBlocStates.todoDeleted]
  void deleteTodo(TodoEntity todo);

  /// Persist the give [todo].
  ///
  /// Subscribe for state changes in
  /// - [TodoListBlocStates.todoAdded]
  /// - [TodoListBlocStates.todoList]
  void addTodo(TodoEntity todo);

  /// Filter the [TodoListBlocStates.todoList] by the give [filter]
  @RxBlocEvent(type: RxBlocEventType.behaviour, seed: VisibilityFilter.all)
  void filterBy(VisibilityFilter filter);
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
  /// - [TodoListBlocEvents.fetchTodos]
  /// - [TodoListBlocEvents.toggleTodoCompletion]
  /// - [TodoListBlocEvents.deleteTodo]
  /// - [TodoListBlocEvents.addTodo]
  /// - [TodoListBlocEvents.filterBy]
  Stream<Result<List<TodoEntity>>> get todoList;

  /// The state of the change of a [TodoEntity]
  ///
  /// This state is controlled by [TodoListBlocEvents.toggleTodoCompletion]
  PublishConnectableStream<void> get todoCompleted;

  /// The state of a successfully deleted [TodoEntity]
  ///
  /// This state is controlled by [TodoListBlocEvents.deleteTodo]
  PublishConnectableStream<TodoEntity> get todoDeleted;

  /// The state of the successfully added [TodoEntity].
  ///
  /// This state is controlled by [TodoListBlocEvents.addTodo]
  PublishConnectableStream<TodoEntity> get todoAdded;

  /// The current [TodoEntity] list filter.
  ///
  /// This state is controlled by [TodoListBlocEvents.filterBy]
  @RxBlocIgnoreState()
  Stream<VisibilityFilter> get currentFilter;
}

@RxBloc()
class TodoListBloc extends $TodoListBloc {
  TodoListBloc(
    ReactiveTodosRepository repository,
    TodoListService service,
  )   : _repository = repository,
        _service = service {
    todoCompleted.connect().addTo(_compositeSubscription);
    todoDeleted.connect().addTo(_compositeSubscription);
    todoAdded.connect().addTo(_compositeSubscription);
  }

  final ReactiveTodosRepository _repository;
  final TodoListService _service;

  @override
  Stream<Result<List<TodoEntity>>> _mapToTodoListState() => Rx.combineLatest2<
          Result<List<TodoEntity>>, VisibilityFilter, Result<List<TodoEntity>>>(
        _$fetchTodosEvent
            .startWith(null)
            .switchMap((_) => _repository.todos().asResultStream()),
        _$filterByEvent,
        (todos, filter) => _service.filterResultTodoListBy(todos, filter),
      ).setResultStateHandler(this);

  @override
  PublishConnectableStream<void> _mapToTodoCompletedState() =>
      _$toggleTodoCompletionEvent
          .switchMap((todo) => _repository
              .updateTodo(
                todo.copyWith(complete: !todo.complete),
              )
              .asResultStream())
          .setResultStateHandler(this)
          .whereSuccess()
          .publish();

  @override
  PublishConnectableStream<TodoEntity> _mapToTodoDeletedState() =>
      _$deleteTodoEvent
          .switchMap((todo) => _repository
              .deleteTodo(
                [todo.id],
              )
              .then((_) => todo)
              .asResultStream())
          .setResultStateHandler(this)
          .whereSuccess()
          .publish();

  @override
  PublishConnectableStream<TodoEntity> _mapToTodoAddedState() => _$addTodoEvent
      .switchMap(
        (todo) =>
            _repository.addNewTodo(todo).then((_) => todo).asResultStream(),
      )
      .setResultStateHandler(this)
      .whereSuccess()
      .publish();

  @override
  Stream<Exception> get errors => errorState;

  @override
  Stream<VisibilityFilter> get currentFilter => _$filterByEvent;
}
