import 'package:flutter_test/flutter_test.dart';
import 'package:rx_bloc/rx_bloc.dart';
import 'package:rx_bloc_library/base/models/error/error_model.dart';

import '../../helpers/golden_helper.dart';
import '../../helpers/models/scenario.dart';
import '../../stubs.dart';
import 'factories/stats_page_factory.dart';

void main() {
  group(
    'StatsPage golden tests',
    () => runGoldenTests(
      [
        generateDeviceBuilder(
          scenario: Scenario(name: 'counter'),
          widget: statsPageFactory(stats: Result.success(Stubs.stats12)),
        ),
        generateDeviceBuilder(
          scenario: Scenario(name: 'error'),
          widget: statsPageFactory(
            stats: Result.error(ErrorGenericModel('test')),
          ),
        ),
        generateDeviceBuilder(
          scenario: Scenario(name: 'loading'),
          widget: statsPageFactory(stats: Result.loading()),
        ),
      ],
    ),
  );
}
