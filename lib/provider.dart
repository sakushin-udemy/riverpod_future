import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'data/postal_code.dart';

StateProvider<String> textProvider = StateProvider((ref) => '');
FutureProvider<PostalCode> apiProvider = FutureProvider((ref) async {
  final text = ref.read(textProvider).state;

  if (text.length != 7) {
    return PostalCode(code: '', data: []);
  }

  final upper = text.substring(0, 3);
  final lower = text.substring(3);

  print(text);

  final apiUrl = Uri.parse(
      'https://madefor.github.io/postal-code-api/api/v1/$upper/$lower.json');
  http.Response resp = await http.get(apiUrl);
  if (resp.statusCode != 200) {
    throw Exception("url not found: $apiUrl");
  }
  var jsonData = json.decode(resp.body);
  return PostalCode.fromJson(jsonData);
});
