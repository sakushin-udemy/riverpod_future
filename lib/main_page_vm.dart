import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/postal_code.dart';
import 'data/postal_code_read.dart';
import 'main_logic.dart';

final _logicProvider = StateProvider<MainLogic>((ref) => MainLogic());
final _postalcodeProvider = StateProvider<String>((ref) => '');
AutoDisposeFutureProviderFamily<PostalCode, String> _apiFamilyProvider =
    FutureProvider.autoDispose
        .family<PostalCode, String>((ref, postalcode) async {
  final logic = ref.watch(_logicProvider);
  if (!logic.willProceed(postalcode)) {
    return PostalCode.empty;
  }
  return await logic.getPostalCode(postalcode);
});

class MainPageVM {
  late final WidgetRef _ref;
  String get postalcode => _ref.watch(_postalcodeProvider);

  AsyncValue<PostalCode> postalCodeWithFamily(String postcode) =>
      _ref.watch(_apiFamilyProvider(postcode));

  AsyncValue<PostalCode> postalCodeWithGenerator(String postcode) =>
      _ref.watch(readPostalCodeProvider(postalCode: postalcode));

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  void onPostalcodeChanged(String postalcode) {
    _ref.read(_postalcodeProvider.notifier).update((state) => postalcode);
  }
}
