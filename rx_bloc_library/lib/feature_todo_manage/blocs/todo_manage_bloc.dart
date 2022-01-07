import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/extensions/todo_entity_extensions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'todo_manage_bloc.rxb.g.dart';

/// A contract class containing all events of the TodoManageBloC.
abstract class TodoManageBlocEvents {
  /// Save (update or create) a [TodoEntity]
  ///
  /// Subscribe for state changes in [TodoManageBlocStates.saved]
  void save();

  /// Set the [TodoEntity.task]. To persist the entity call [save].
  ///
  /// Subscribe for state changes in [TodoManageBlocStates.task]
  @RxBlocEvent(type: RxBlocEventType.behaviour)
  void setTask(String task);

  /// Set the [TodoEntity.note]. To persist the entity call [save].
  ///
  /// Subscribe for state changes in [TodoManageBlocStates.note]
  @RxBlocEvent(type: RxBlocEventType.behaviour)
  void setNote(String note);
}

/// A contract class containing all states of the TodoManageBloC.
abstract class TodoManageBlocStates {
  /// The state where all errors of the async operations in this bloc
  /// are reported.
  @RxBlocIgnoreState()
  Stream<Exception> get errors;

  /// The state of the current [TodoEntity.task]
  ///
  /// This state is controlled by [TodoManageBlocEvents.setTask]
  Stream<String> get task;

  /// The state of the current [TodoEntity.note]
  ///
  /// /// This state is controlled by [TodoManageBlocEvents.setNote]
  Stream<String> get note;

  /// The state of the successfully saved (created or updated) [TaskEntity]
  Stream<TodoEntity> get saved;
}

@RxBloc()
class TodoManageBloc extends $TodoManageBloc {
  TodoManageBloc(
    ReactiveTodosRepository repository, {
    required TodoEntity? todoEntity,
  })  : _todoEntity = todoEntity ?? TodoEntityX.empty(),
        _repository = repository,
        _isEditing = todoEntity != null;

  final TodoEntity _todoEntity;
  final ReactiveTodosRepository _repository;
  final bool _isEditing;

  @override
  Stream<String> _mapToNoteState() => _$setNoteEvent
      .startWith(_todoEntity.note)
      .distinct()
      .shareReplay(maxSize: 1);

  @override
  Stream<String> _mapToTaskState() => _$setTaskEvent
      .startWith(_todoEntity.task)
      .distinct()
      .shareReplay(maxSize: 1);

  @override
  Stream<TodoEntity> _mapToSavedState() => _$saveEvent
      .throttleTime(Duration(seconds: 1))
      .switchMap(
        (value) {
          final updatedEntity = _copyTodoWithEventsData();

          if (_isEditing) {
            return _repository
                .updateTodo(updatedEntity)
                .then((value) => updatedEntity)
                .asResultStream();
          }
          return _repository
              .addNewTodo(updatedEntity)
              .then((value) => updatedEntity)
              .asResultStream();
        },
      )
      .setResultStateHandler(this)
      .whereSuccess()
      .share();

  TodoEntity _copyTodoWithEventsData() => _todoEntity.copyWith(
        task: _$setTaskEvent.hasValue ? _$setTaskEvent.value : '',
        note: _$setNoteEvent.hasValue ? _$setNoteEvent.value : '',
      );

  @override
  Stream<Exception> get errors => errorState;
}
