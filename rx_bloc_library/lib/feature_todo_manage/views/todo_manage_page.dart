import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/todo_manage_bloc.dart';
import '../di/todo_manage_dependencies.dart';

class TodoManagePage extends StatelessWidget {
  const TodoManagePage({
    Key? key,
  }) : super(key: key);

  static Widget withDependencies(BuildContext context, {Key? key}) =>
      MultiProvider(
        providers: TodoManageDependencies.of(context).providers,
        child: TodoManagePage(
          key: key,
        ),
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
            onPressed: context.read<TodoManageBlocType>().events.fetchData,
          ),
        ],
      );

  Widget _buildDataContainer() => RxResultBuilder<TodoManageBlocType, String>(
        state: (bloc) => bloc.states.data,
        buildLoading: (ctx, bloc) => const CircularProgressIndicator(),
        buildError: (ctx, error, bloc) => Text(error.toString()),
        buildSuccess: (ctx, state, bloc) => Text(state),
      );

  Widget _buildErrorListener() => RxBlocListener<TodoManageBlocType, String>(
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
