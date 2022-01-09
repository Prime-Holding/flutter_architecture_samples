// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'todo_details_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class TodoDetailsBlocType extends RxBlocTypeBase {
  TodoDetailsBlocEvents get events;
  TodoDetailsBlocStates get states;
}

/// [$TodoDetailsBloc] extended by the [TodoDetailsBloc]
/// {@nodoc}
abstract class $TodoDetailsBloc extends RxBlocBase
    implements
        TodoDetailsBlocEvents,
        TodoDetailsBlocStates,
        TodoDetailsBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetch]
  final _$fetchEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [toggleCompletion]
  final _$toggleCompletionEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [delete]
  final _$deleteEvent = PublishSubject<void>();

  /// The state of [todo] implemented in [_mapToTodoState]
  late final Stream<TodoEntity> _todoState = _mapToTodoState();

  /// The state of [onCompleted] implemented in [_mapToOnCompletedState]
  late final PublishConnectableStream<bool> _onCompletedState =
      _mapToOnCompletedState();

  /// The state of [onDeleted] implemented in [_mapToOnDeletedState]
  late final Stream<TodoEntity> _onDeletedState = _mapToOnDeletedState();

  @override
  void fetch() => _$fetchEvent.add(null);

  @override
  void toggleCompletion() => _$toggleCompletionEvent.add(null);

  @override
  void delete() => _$deleteEvent.add(null);

  @override
  Stream<TodoEntity> get todo => _todoState;

  @override
  PublishConnectableStream<bool> get onCompleted => _onCompletedState;

  @override
  Stream<TodoEntity> get onDeleted => _onDeletedState;

  Stream<TodoEntity> _mapToTodoState();

  PublishConnectableStream<bool> _mapToOnCompletedState();

  Stream<TodoEntity> _mapToOnDeletedState();

  @override
  TodoDetailsBlocEvents get events => this;

  @override
  TodoDetailsBlocStates get states => this;

  @override
  void dispose() {
    _$fetchEvent.close();
    _$toggleCompletionEvent.close();
    _$deleteEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
