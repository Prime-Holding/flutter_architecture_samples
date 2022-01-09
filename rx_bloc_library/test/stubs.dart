import 'package:rx_bloc_library/base/models/error/error_model.dart';
import 'package:rx_bloc_library/base/models/stats_model.dart';

class Stubs {
  static StatsModel get stats22 => StatsModel(
        numActive: 2,
        numCompleted: 2,
      );

  static StatsModel get stats12 => StatsModel(
        numActive: 1,
        numCompleted: 2,
      );

  static ErrorModel get genericModel => ErrorGenericModel('test');
}
