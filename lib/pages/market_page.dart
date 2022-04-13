import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_tracker/models/coingeko_model.dart';
import 'package:price_tracker/providers/market_providers.dart';
import 'package:price_tracker/widgets/crypto_list_tile.dart';
import 'package:provider/provider.dart';

import 'details_page.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (_, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketProvider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchAllCryptocurrencyData();
              },
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: marketProvider.markets.length,
                  itemBuilder: (_, index) {
                    CoingekoModel coingekoModel = marketProvider.markets[index];
                    return CryptoListTile(coingekoModel: coingekoModel);
                  }),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchAllCryptocurrencyData();
              },
              child: Center(
                child: ListView(
                  children: const [
                    SizedBox(
                      height: 200,
                    ),
                    Center(child: Text("No data Found!"))
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
