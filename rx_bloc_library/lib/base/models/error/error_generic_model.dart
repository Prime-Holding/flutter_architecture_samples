part of 'error_model.dart';

class ErrorGenericModel extends ErrorModel with EquatableMixin {
  final String message;

  ErrorGenericModel(this.message);

  @override
  List<Object?> get props => [message];
}
