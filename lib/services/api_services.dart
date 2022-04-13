import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:price_tracker/constants/tools.dart';

class ApiServices {
  static Future<List<dynamic>> getMarkets() async {
    try {
      Uri requestpath = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");

      var response = await http.get(requestpath);
      var decodedJson = jsonDecode(response.body);
      List<dynamic> markets = decodedJson as List<dynamic>;
      debugPrint(markets.toString());
      return markets;
    } catch (ex) {
      return [];
    }
  }

  static Future<List<dynamic>> getChart(String id) async {
    try {
      Uri requestpath = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=inr&days=7");

      var response = await http.get(requestpath);
      var decodedJson = jsonDecode(response.body);
      debugPrint(decodedJson.toString());
      List<dynamic> markets = decodedJson as List<dynamic>;
      debugPrint(markets.toString());

      return markets;
    } catch (ex) {
      debugPrint("There is an Error $ex");
      return [];
    }
  }
}
