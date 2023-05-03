import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:daily_meals/utils/make_uri.dart';

class Methods {
  final http.Client client = http.Client();

  Future<dynamic> get(String uri, {String path = "", params}) async {
    final url = makeUri(uri, path, params);
    final res = await client.get(url);
    final resVal = jsonDecode(utf8.decode(res.bodyBytes));

    if (res.statusCode == 200) {
      return resVal;
    } else {
      throw HttpException(res.body);
    }
  }
}
