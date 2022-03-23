import 'dart:convert';

import 'package:riverpod_future/data/postal_code.dart';
import 'package:http/http.dart' as http;

class MainLogic {
  Future<PostalCode> getPostalCode(String postalcode) async {
    if (postalcode.length != 7) {
      throw Exception("Postal Code must be 7 charactors");
    }

    // 123-4567
    final upper = postalcode.substring(0, 3); //123
    final lower = postalcode.substring(3); // 4567

    //https://madefor.github.io/postal-code-api/api/v1/100/0014.json
    final apiUrl =
        'https://madefor.github.io/postal-code-api/api/v1/$upper/$lower.json';
    final apiUri = Uri.parse(apiUrl);
    http.Response response = await http.get(apiUri);

    if (response.statusCode != 200) {
      throw Exception('No postal code: $postalcode');
    }

    var jsonData = json.decode(response.body);
    return PostalCode.fromJson(jsonData);
  }

  bool willProceed(String postalcode) {
    return postalcode.length == 7;
  }
}
