import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rx_bloc_library/base/models/models.dart';
import 'package:rx_bloc_library/feature_stats/views/stats_page.dart';
import 'package:rx_bloc_library/feature_todo_list/views/todo_list_page.dart';
import 'package:rx_bloc_library/base/widgets/widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';

import '../../base/localization.dart';
import '../blocs/home_bloc.dart';
import '../di/home_dependencies.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static Widget withDependencies(BuildContext context) => MultiProvider(
        providers: HomeDependencies.of(context).providers,
        child: HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return RxBlocBuilder<HomeBlocType, AppTab>(
      state: (bloc) => bloc.states.selectedTab,
      builder: (context, tab, bloc) {
        final activeTab = tab.data ?? AppTab.todos;

        return Scaffold(
          appBar: AppBar(
            title: Text(FlutterRxBlocLocalizations.of(context).appTitle),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos
              ? TodoListPage.withDependencies(context)
              : StatsPage.withDependencies(context),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addTodo,
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => bloc.events.selectTab(tab),
          ),
        );
      },
    );
  }
}
