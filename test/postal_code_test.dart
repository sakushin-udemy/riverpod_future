import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_future/data/postal_code.dart';

void main() {
  //https://madefor.github.io/postal-code-api/api/v1/100/0014.json
  String jsonCode = '''
{
  "code": "1000014",
  "data": [
    {
      "prefcode": "13",
      "ja": {
        "prefecture": "東京都",
        "address1": "千代田区",
        "address2": "永田町",
        "address3": "",
        "address4": ""
      },
      "en": {
        "prefecture": "Tokyo",
        "address1": "Chiyoda-ku",
        "address2": "Nagatacho",
        "address3": "",
        "address4": ""
      }
    }
  ]
}
  ''';

  test('init', () async {
    var jsonData = json.decode(jsonCode);
    PostalCode result = PostalCode.fromJson(jsonData);

    expect(result.code, '1000014');
    expect(result.data.length, 1);

    expect(result.data[0].prefcode, '13');
    expect(result.data[0].ja.prefecture, '東京都');
    expect(result.data[0].en.prefecture, 'Tokyo');
    expect(result.data[0].en.address1, 'Chiyoda-ku');
    expect(result.data[0].en.address2, 'Nagatacho');
    expect(result.data[0].en.address3, '');
    expect(result.data[0].en.address4, '');
  });
}
