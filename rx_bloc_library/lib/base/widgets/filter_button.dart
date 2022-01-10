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

    final button = RxBlocBuilder<TodoListBlocType, VisibilityFilterModel>(
      state: (bloc) => bloc.states.currentFilter,
      builder: (context, snapshot, bloc) => _Button(
        onSelected: (filter) =>
            context.read<TodoListBlocType>().events.filterBy(filter),
        activeFilter: snapshot.data ?? VisibilityFilterModel.all,
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

  final PopupMenuItemSelected<VisibilityFilterModel> onSelected;
  final VisibilityFilterModel activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilterModel>(
      key: ArchSampleKeys.filterButton,
      tooltip: ArchSampleLocalizations.of(context).filterTodos,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) =>
          <PopupMenuItem<VisibilityFilterModel>>[
        PopupMenuItem<VisibilityFilterModel>(
          key: ArchSampleKeys.allFilter,
          value: VisibilityFilterModel.all,
          child: Text(
            ArchSampleLocalizations.of(context).showAll,
            style: activeFilter == VisibilityFilterModel.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilterModel>(
          key: ArchSampleKeys.activeFilter,
          value: VisibilityFilterModel.active,
          child: Text(
            ArchSampleLocalizations.of(context).showActive,
            style: activeFilter == VisibilityFilterModel.active
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilterModel>(
          key: ArchSampleKeys.completedFilter,
          value: VisibilityFilterModel.completed,
          child: Text(
            ArchSampleLocalizations.of(context).showCompleted,
            style: activeFilter == VisibilityFilterModel.completed
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
