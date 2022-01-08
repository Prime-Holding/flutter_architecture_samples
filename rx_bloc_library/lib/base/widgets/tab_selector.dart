// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:rx_bloc_library/base/models/models.dart';

class TabSelector extends StatelessWidget {
  final AppTabModel activeTab;
  final Function(AppTabModel) onTabSelected;

  TabSelector({
    required this.activeTab,
    required this.onTabSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: ArchSampleKeys.tabs,
      currentIndex: AppTabModel.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTabModel.values[index]),
      items: AppTabModel.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTabModel.todos ? Icons.list : Icons.show_chart,
            key: tab == AppTabModel.todos
                ? ArchSampleKeys.todoTab
                : ArchSampleKeys.statsTab,
          ),
          title: Text(tab == AppTabModel.stats
              ? ArchSampleLocalizations.of(context).stats
              : ArchSampleLocalizations.of(context).todos),
        );
      }).toList(),
    );
  }
}
