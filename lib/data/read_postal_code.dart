import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_future/data/postal_code.dart';
import 'package:riverpod_future/main_logic.dart';

part 'read_postal_code.g.dart';

@riverpod
Future<PostalCode> readPotalCode(ref, {required String postalCode}) async {
  final logic = MainLogic();
  if (!logic.willProceed(postalCode)) {
    return PostalCode.empty;
  }
  return logic.getPostalCode(postalCode);
}
