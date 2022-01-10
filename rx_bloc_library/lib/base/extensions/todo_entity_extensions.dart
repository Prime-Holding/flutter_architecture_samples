// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

extension TodoEntityX on TodoEntity {
  TodoEntity copyWith({
    bool? complete,
    String? id,
    String? note,
    String? task,
  }) =>
      TodoEntity(
        task ?? this.task,
        id ?? this.id,
        note ?? this.note,
        complete ?? this.complete,
      );

  /// Create an instance of [TodoEntity] with generated uuid and empty fields
  static TodoEntity empty() => TodoEntity(
        '',
        Uuid().generateV4(),
        '',
        false,
      );
}
