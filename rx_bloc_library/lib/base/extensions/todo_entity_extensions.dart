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

  static TodoEntity empty() => TodoEntity(
        '',
        Uuid().generateV4(),
        '',
        false,
      );
}
