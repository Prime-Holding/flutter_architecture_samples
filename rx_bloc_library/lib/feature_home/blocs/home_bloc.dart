// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rxdart/rxdart.dart';

part 'home_bloc.rxb.g.dart';

/// A contract class containing all events of the HomeBloC.
abstract class HomeBlocEvents {
  /// Select the [tap] that needs to be put on screen.
  ///
  /// Subscribe for state changes in [HomeBlocStates.selectedTab]
  void selectTab(AppTab tab);
}

/// A contract class containing all states of the HomeBloC.
abstract class HomeBlocStates {
  /// The state of the currently selected tab.
  ///
  /// This state is controlled by [HomeBlocEvents.selectTab]
  Stream<AppTab> get selectedTab;
}

@RxBloc()
class HomeBloc extends $HomeBloc {
  @override
  Stream<AppTab> _mapToSelectedTabState() =>
      _$selectTabEvent.startWith(AppTab.todos);
}
