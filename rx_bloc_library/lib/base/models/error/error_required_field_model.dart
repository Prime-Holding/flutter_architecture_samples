part of 'error_model.dart';

class ErrorRequiredFieldModel<T> extends ErrorModel {
  ErrorRequiredFieldModel({
    required this.fieldValue,
  });

  final T fieldValue;

  @override
  String toString() => 'Value: $fieldValue.';
}
