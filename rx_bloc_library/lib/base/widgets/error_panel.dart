import 'package:flutter/widgets.dart';

class ErrorPanel extends StatelessWidget {
  const ErrorPanel({
    required this.exception,
    Key? key,
  }) : super(key: key);

  final Exception exception;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          exception.toString(),
        ),
      );
}
