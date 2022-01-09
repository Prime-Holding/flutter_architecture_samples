// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:equatable/equatable.dart';

class StatsModel with EquatableMixin {
  StatsModel({
    required this.numActive,
    required this.numCompleted,
  });

  final int numActive;
  final int numCompleted;

  @override
  List<Object?> get props => [numActive, numCompleted];
}
