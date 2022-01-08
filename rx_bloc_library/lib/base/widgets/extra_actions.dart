// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:rx_bloc_library/base/models/extra_action_model.dart';
import 'package:rx_bloc_library/feature_home/blocs/home_bloc.dart';
import 'package:rx_bloc_library/feature_todo_list/blocs/todo_list_bloc.dart';

import 'package:todos_app_core/todos_app_core.dart';

import '../rx_bloc_library_keys.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key? key}) : super(key: ArchSampleKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraActionModel>(
      key: RxBlocLibraryKeys.extraActionsPopupMenuButton,
      onSelected: (action) {
        switch (action) {
          case ExtraActionModel.clearCompleted:
            context.read<HomeBlocType>().events.deleteTodoListCompleted();
            break;
          case ExtraActionModel.toggleAllComplete:
            context.read<HomeBlocType>().events.toggleTodoListCompletion();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraActionModel>>[
        PopupMenuItem<ExtraActionModel>(
          key: ArchSampleKeys.toggleAll,
          value: ExtraActionModel.toggleAllComplete,
          child: RxBlocBuilder<HomeBlocType, bool>(
            bloc: context.read<HomeBlocType>(),
            state: (bloc) => bloc.states.allTodoListComplete,
            builder: (context, snapshot, bloc) => Text(
              snapshot.data ?? true
                  ? ArchSampleLocalizations.of(context).markAllIncomplete
                  : ArchSampleLocalizations.of(context).markAllComplete,
            ),
          ),
        ),
        PopupMenuItem<ExtraActionModel>(
          key: ArchSampleKeys.clearCompleted,
          value: ExtraActionModel.clearCompleted,
          child: Text(
            ArchSampleLocalizations.of(context).clearCompleted,
          ),
        ),
      ],
    );
  }
}
