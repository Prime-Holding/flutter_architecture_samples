// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:rx_bloc_library/feature_todo_list/blocs/todo_list_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

import '../models/models.dart';

class FilterButton extends StatelessWidget {
  final bool visible;

  FilterButton({
    required this.visible,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeStyle = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: Theme.of(context).colorScheme.secondary);

    final defaultStyle = Theme.of(context).textTheme.bodyText1!;

    final button = RxBlocBuilder<TodoListBlocType, VisibilityFilter>(
      state: (bloc) => bloc.states.currentFilter,
      builder: (context, snapshot, bloc) => _Button(
        onSelected: (filter) =>
            context.read<TodoListBlocType>().events.filterBy(filter),
        activeFilter: snapshot.data ?? VisibilityFilter.all,
        activeStyle: activeStyle,
        defaultStyle: defaultStyle,
      ),
    );
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 150),
      child: visible ? button : IgnorePointer(child: button),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onSelected,
    required this.activeFilter,
    required this.activeStyle,
    required this.defaultStyle,
    Key? key,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: ArchSampleKeys.filterButton,
      tooltip: ArchSampleLocalizations.of(context).filterTodos,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            ArchSampleLocalizations.of(context).showAll,
            style: activeFilter == VisibilityFilter.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.activeFilter,
          value: VisibilityFilter.active,
          child: Text(
            ArchSampleLocalizations.of(context).showActive,
            style: activeFilter == VisibilityFilter.active
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.completedFilter,
          value: VisibilityFilter.completed,
          child: Text(
            ArchSampleLocalizations.of(context).showCompleted,
            style: activeFilter == VisibilityFilter.completed
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
