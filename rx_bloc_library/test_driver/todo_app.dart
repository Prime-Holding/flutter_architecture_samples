// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_driver/driver_extension.dart';
import 'package:rx_bloc_library/main.dart' as app;

void main() {
  enableFlutterDriverExtension();

  app.main();
}
