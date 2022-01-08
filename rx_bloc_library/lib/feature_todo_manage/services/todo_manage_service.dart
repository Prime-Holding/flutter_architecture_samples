import 'package:rx_bloc_library/base/models/error/error_model.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class TodoManageService {
  /// Validate the given [task].
  ///
  /// Rules:
  ///   The string should not be empty.
  String validateTask(String task) {
    if (task.isEmpty) {
      throw ErrorRequiredFieldModel(
        fieldValue: task,
      );
    }
    return task;
  }

  /// Validate the given [todoEntity] based on specific criteria.
  bool isTodoValid(TodoEntity todoEntity) {
    try {
      validateTask(todoEntity.task);
      return true;
    } catch (e) {
      return false;
    }
  }
}
