// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'home_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class HomeBlocType extends RxBlocTypeBase {
  HomeBlocEvents get events;
  HomeBlocStates get states;
}

/// [$HomeBloc] extended by the [HomeBloc]
/// {@nodoc}
abstract class $HomeBloc extends RxBlocBase
    implements HomeBlocEvents, HomeBlocStates, HomeBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [selectTab]
  final _$selectTabEvent = PublishSubject<AppTabModel>();

  /// Тhe [Subject] where events sink to by calling [deleteTodoListCompleted]
  final _$deleteTodoListCompletedEvent = PublishSubject<void>();

  /// Тhe [Subject] where events sink to by calling [toggleTodoListCompletion]
  final _$toggleTodoListCompletionEvent = PublishSubject<void>();

  /// The state of [selectedTab] implemented in [_mapToSelectedTabState]
  late final Stream<AppTabModel> _selectedTabState = _mapToSelectedTabState();

  /// The state of [completeTodoListDeleted] implemented in
  /// [_mapToCompleteTodoListDeletedState]
  late final PublishConnectableStream<void> _completeTodoListDeletedState =
      _mapToCompleteTodoListDeletedState();

  /// The state of [todoListCompleted] implemented in
  /// [_mapToTodoListCompletedState]
  late final PublishConnectableStream<void> _todoListCompletedState =
      _mapToTodoListCompletedState();

  /// The state of [allTodoListComplete] implemented in
  /// [_mapToAllTodoListCompleteState]
  late final Stream<bool> _allTodoListCompleteState =
      _mapToAllTodoListCompleteState();

  @override
  void selectTab(AppTabModel tab) => _$selectTabEvent.add(tab);

  @override
  void deleteTodoListCompleted() => _$deleteTodoListCompletedEvent.add(null);

  @override
  void toggleTodoListCompletion() => _$toggleTodoListCompletionEvent.add(null);

  @override
  Stream<AppTabModel> get selectedTab => _selectedTabState;

  @override
  PublishConnectableStream<void> get completeTodoListDeleted =>
      _completeTodoListDeletedState;

  @override
  PublishConnectableStream<void> get todoListCompleted =>
      _todoListCompletedState;

  @override
  Stream<bool> get allTodoListComplete => _allTodoListCompleteState;

  Stream<AppTabModel> _mapToSelectedTabState();

  PublishConnectableStream<void> _mapToCompleteTodoListDeletedState();

  PublishConnectableStream<void> _mapToTodoListCompletedState();

  Stream<bool> _mapToAllTodoListCompleteState();

  @override
  HomeBlocEvents get events => this;

  @override
  HomeBlocStates get states => this;

  @override
  void dispose() {
    _$selectTabEvent.close();
    _$deleteTodoListCompletedEvent.close();
    _$toggleTodoListCompletionEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
