import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'knox.dart';

/// A variant of [HydratedBlocDelegate] which can build
/// a [Knox] instance using `build()`
class KnoxDelegate extends HydratedBlocDelegate {
  /// Constructs a [KnoxDelegate] object with the optional [storage]
  KnoxDelegate(HydratedStorage storage) : super(storage);

  /// Builds a [KnoxDelegate] with an instance of [Knox]
  static Future<KnoxDelegate> build() async => KnoxDelegate(await Knox.getInstance());
}
