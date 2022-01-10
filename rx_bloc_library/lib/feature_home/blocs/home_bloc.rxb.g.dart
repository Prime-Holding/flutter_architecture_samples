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

  /// The state of [selectedTab] implemented in [_mapToSelectedTabState]
  late final Stream<AppTabModel> _selectedTabState = _mapToSelectedTabState();

  @override
  void selectTab(AppTabModel tab) => _$selectTabEvent.add(tab);

  @override
  Stream<AppTabModel> get selectedTab => _selectedTabState;

  Stream<AppTabModel> _mapToSelectedTabState();

  @override
  HomeBlocEvents get events => this;

  @override
  HomeBlocStates get states => this;

  @override
  void dispose() {
    _$selectTabEvent.close();
    _compositeSubscription.dispose();
    super.dispose();
  }
}
