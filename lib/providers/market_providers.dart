import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:price_tracker/models/chart_model.dart';
import 'package:price_tracker/models/coingeko_model.dart';
import 'package:price_tracker/services/api_services.dart';
import 'package:price_tracker/services/shared_preferences_storage.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CoingekoModel> markets = [];
  List<ChartModel> charts = [];

  MarketProvider() {
    fetchAllCryptocurrencyData();
  }

  Future<void> fetchAllCryptocurrencyData() async {
    List<dynamic> _market = await ApiServices.getMarkets();
    List<String> favorites = await SharedPreferenceStorage.getFavorites();
    List<CoingekoModel> temp = [];

    for (var market in _market) {
      CoingekoModel coingekoModel = CoingekoModel.fromJson(market);
      if (favorites.contains(coingekoModel.id!)) {
        coingekoModel.isFavorite = true;
      }
      temp.add(coingekoModel);
    }

    markets = temp;
    isLoading = false;
    notifyListeners();

    // This was used to refresh the Data After every 20 secons
/*    Timer(const Duration(seconds: 20), () {
      fetch();
      debugPrint("Data Updated Again After 20 Seconds !");
    });*/
  }

  Future<void> fetchCryptoChart(String id) async {
    List<dynamic> _chart = await ApiServices.getChart(id);

    List<ChartModel> temp = [];

    for (var chart in _chart) {
      temp.add(chart);
    }

    charts = temp;
    isLoading = false;
    notifyListeners();
  }

  CoingekoModel fetchCurrencyById(String id) {
    CoingekoModel coingekoModel =
        markets.where((element) => element.id == id).toList()[0];
    return coingekoModel;
  }

  void addFavorite(CoingekoModel coingekoModel) async {
    int indexOfCrypto = markets.indexOf(coingekoModel);
    markets[indexOfCrypto].isFavorite = true;
    await SharedPreferenceStorage.addFavorite(coingekoModel.id!);
    notifyListeners();
  }

  void removeFavorite(CoingekoModel coingekoModel) async {
    int indexOfCrypto = markets.indexOf(coingekoModel);
    markets[indexOfCrypto].isFavorite = false;
    await SharedPreferenceStorage.removeFavorite(coingekoModel.id!);
    notifyListeners();
  }
}
