import 'package:flutter/widgets.dart';
import 'package:flutter_rx_bloc/rx_form.dart';
import 'package:todos_app_core/todos_app_core.dart';

import '../models/error/error_model.dart';

extension StreamFieldErrors<T> on Stream<T> {
  /// Localize the errors from an RxFormField steam
  Stream<T> translateErrors(BuildContext context) {
    return handleError((error) {
      if (error is ErrorRequiredFieldModel) {
        throw RxFieldException<T>(
          error: ArchSampleLocalizations.of(context).emptyTodoError,
          fieldValue: error.fieldValue,
        );
      }

      throw error;
    });
  }
}
