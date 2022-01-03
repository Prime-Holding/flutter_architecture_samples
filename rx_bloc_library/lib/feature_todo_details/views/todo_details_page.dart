import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/todo_details_bloc.dart';
import '../di/todo_details_dependencies.dart';

class TodoDetailsPage extends StatelessWidget {
  const TodoDetailsPage({
    Key? key,
  }) : super(key: key);

  static Widget withDependencies(BuildContext context) => MultiProvider(
        providers: TodoDetailsDependencies.of(context).providers,
        child: TodoDetailsPage(),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildErrorListener(),
            Center(child: _buildDataContainer()),
          ],
        ),
      );

  AppBar _buildAppBar(BuildContext context) => AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: context.read<TodoDetailsBlocType>().events.fetchData,
          ),
        ],
      );

  Widget _buildDataContainer() => RxResultBuilder<TodoDetailsBlocType, String>(
        state: (bloc) => bloc.states.data,
        buildLoading: (ctx, bloc) => const CircularProgressIndicator(),
        buildError: (ctx, error, bloc) => Text(error.toString()),
        buildSuccess: (ctx, state, bloc) => Text(state),
      );

  Widget _buildErrorListener() => RxBlocListener<TodoDetailsBlocType, String>(
        state: (bloc) => bloc.states.errors,
        listener: (context, errorMessage) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage ?? ''),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );
}
