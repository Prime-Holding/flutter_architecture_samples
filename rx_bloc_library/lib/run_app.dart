// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:provider/provider.dart';
import 'package:rx_bloc_library/feature_home/views/home_page.dart';
import 'package:rx_bloc_library/base/localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';
import 'package:todos_repository_local_storage/todos_repository_local_storage.dart';

import 'base/app_dependencies.dart';
import 'feature_todo_manage/views/todo_manage_page.dart';

void runBlocLibraryApp() {
  runApp(TodosApp());
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: AppDependencies.from(context).providers,
        child: MaterialApp(
          onGenerateTitle: (context) =>
              FlutterRxBlocLocalizations.of(context).appTitle,
          theme: ArchSampleTheme.theme,
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            FlutterBlocLocalizationsDelegate(),
          ],
          routes: {
            ArchSampleRoutes.home: (context) =>
                HomePage.withDependencies(context),
            ArchSampleRoutes.addTodo: (context) =>
                TodoManagePage.withDependencies(
                  context,
                  key: ArchSampleKeys.addTodoScreen,
                  // onSave: (task, note) {
                  //   todosBloc.add(AddTodo(Todo(task, note: note)));
                  // },
                  // isEditing: false,
                ),
          },
        ),
      );
}
