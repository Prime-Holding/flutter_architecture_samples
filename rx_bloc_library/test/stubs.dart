import 'package:rx_bloc_library/base/models/error/error_model.dart';
import 'package:rx_bloc_library/base/models/stats_model.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class Stubs {
  static StatsModel get statsActive2Completed2 => StatsModel(
        numActive: 2,
        numCompleted: 2,
      );

  static StatsModel get statsActive1Completed2 => StatsModel(
        numActive: 1,
        numCompleted: 2,
      );

  static StatsModel get statsActive2Completed3 => StatsModel(
        numActive: 2,
        numCompleted: 3,
      );

  static List<TodoEntity> get todosActive2Completed3 => [
        TodoEntity('completed 1', '1', '', true),
        TodoEntity('completed 2', '2', '', true),
        TodoEntity('completed 3', '3', '', true),
        TodoEntity('active 1', '4', '', false),
        TodoEntity('active 2', '5', '', false),
      ];

  static List<TodoEntity> get todosActive => [
        TodoEntity('active 1', '4', '', false),
        TodoEntity('active 2', '5', '', false),
      ];

  static List<TodoEntity> get todosCompleted => [
        TodoEntity('completed 1', '1', '', true),
        TodoEntity('completed 2', '2', '', true),
        TodoEntity('completed 3', '3', '', true),
      ];

  static TodoEntity get todoCompleted =>
      TodoEntity('completed 1', '1', '', true);

  static TodoEntity get todoActive => TodoEntity('completed 1', '1', '', false);

  static ErrorModel get genericModel => ErrorGenericModel('test');
}
