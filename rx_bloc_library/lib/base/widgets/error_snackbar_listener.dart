import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:rx_bloc/rx_bloc.dart';

class ErrorSnackBarListener<B extends RxBlocTypeBase> extends StatelessWidget {
  const ErrorSnackBarListener({
    required this.errorState,
    Key? key,
  }) : super(key: key);

  final Stream<Exception> Function(B) errorState;

  @override
  Widget build(BuildContext context) => RxBlocListener<B, Exception>(
        state: (bloc) => errorState(bloc),
        listener: (context, errorMessage) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage.toString()),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );
}
