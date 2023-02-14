import 'dart:io';

import 'package:http/http.dart' as http;

String baseUrl = "";
FuturegetStockPrices () async {
  final response = await http.get(Uri.parse(baseUrl));
  return response.body;
}
