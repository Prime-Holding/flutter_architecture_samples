// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Stats extends StatelessWidget {
  Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container();
  // Widget build(BuildContext context) {
  //   final statsBloc = BlocProvider.of<StatsBloc>(context);
  //   return BlocBuilder(
  //     bloc: statsBloc,
  //     builder: (BuildContext context, StatsState state) {
  //       if (state is StatsLoading) {
  //         return LoadingIndicator(key: BlocLibraryKeys.statsLoadingIndicator);
  //       } else if (state is StatsLoaded) {
  //         return Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.only(bottom: 8.0),
  //                 child: Text(
  //                   ArchSampleLocalizations.of(context).completedTodos,
  //                   style: Theme.of(context).textTheme.title,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(bottom: 24.0),
  //                 child: Text(
  //                   '${state.numCompleted}',
  //                   key: ArchSampleKeys.statsNumCompleted,
  //                   style: Theme.of(context).textTheme.subhead,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(bottom: 8.0),
  //                 child: Text(
  //                   ArchSampleLocalizations.of(context).activeTodos,
  //                   style: Theme.of(context).textTheme.title,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(bottom: 24.0),
  //                 child: Text(
  //                   '${state.numActive}',
  //                   key: ArchSampleKeys.statsNumActive,
  //                   style: Theme.of(context).textTheme.subhead,
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       } else {
  //         return Container(key: BlocLibraryKeys.emptyStatsContainer);
  //       }
  //     },
  //   );
  // }
}
