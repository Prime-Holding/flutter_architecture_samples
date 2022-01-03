import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/models/models.dart';
import 'package:rxdart/rxdart.dart';

part 'home_bloc.rxb.g.dart';

/// A contract class containing all events of the HomeBloC.
abstract class HomeBlocEvents {
  void selectTab(AppTab tab);
}

/// A contract class containing all states of the HomeBloC.
abstract class HomeBlocStates {
  Stream<AppTab> get selectedTab;
}

@RxBloc()
class HomeBloc extends $HomeBloc {
  @override
  Stream<AppTab> _mapToSelectedTabState() =>
      _$selectTabEvent.startWith(AppTab.todos);
}
