// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: RxBlocGeneratorForAnnotation
// **************************************************************************

part of 'stats_bloc.dart';

/// Used as a contractor for the bloc, events and states classes
/// {@nodoc}
abstract class StatsBlocType extends RxBlocTypeBase {
  StatsBlocEvents get events;
  StatsBlocStates get states;
}

/// [$StatsBloc] extended by the [StatsBloc]
/// {@nodoc}
abstract class $StatsBloc extends RxBlocBase
    implements StatsBlocEvents, StatsBlocStates, StatsBlocType {
  final _compositeSubscription = CompositeSubscription();

  /// Тhe [Subject] where events sink to by calling [fetchData]
  final _$fetchDataEvent = PublishSubject<void>();

  /// The state of [errors] implemented in [_mapToErrorsState]
  late final Stream<String> _errorsState = _mapToErrorsState();

  /// The state of [stats] implemented in [_mapToStatsState]
  late final Stream<Result<Stats>> _statsState = _mapToStatsState();

  @override
  void fetchData() => _$fetchDataEvent.add(null);

  @override
  Stream<String> get errors => _errorsState;

  @override
  Stream<Result<Stats>> get stats => _statsState;

  Stream<String> _mapToErrorsState();

  Stream<Result<Stats>> _mapToStatsState();

  @override
  StatsBlocEvents get events => this;

  @override
  StatsBlocStates get states => this;

  @override
  void dispose() {
    _$fetchDataEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
