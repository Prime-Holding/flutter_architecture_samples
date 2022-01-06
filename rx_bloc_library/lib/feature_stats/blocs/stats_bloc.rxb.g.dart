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

  /// Тhe [Subject] where events sink to by calling [fetchStats]
  final _$fetchStatsEvent = PublishSubject<void>();

  /// The state of [stats] implemented in [_mapToStatsState]
  late final Stream<Result<Stats>> _statsState = _mapToStatsState();

  @override
  void fetchStats() => _$fetchStatsEvent.add(null);

  @override
  Stream<Result<Stats>> get stats => _statsState;

  Stream<Result<Stats>> _mapToStatsState();

  @override
  StatsBlocEvents get events => this;

  @override
  StatsBlocStates get states => this;

  @override
  void dispose() {
    _$fetchStatsEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
