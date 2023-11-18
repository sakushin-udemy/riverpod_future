import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_future/data/postal_code.dart';

import '../main_logic.dart';
part 'postal_code_read.g.dart';

@riverpod
Future<PostalCode> readPostalCode(ref, {required String postalCode}) async {
  final logic = MainLogic();
  if (!logic.willProceed(postalCode)) {
    return PostalCode.empty;
  }
  return logic.getPostalCode(postalCode);
}
