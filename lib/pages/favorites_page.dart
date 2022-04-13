import 'package:flutter/material.dart';
import 'package:price_tracker/models/coingeko_model.dart';
import 'package:price_tracker/providers/market_providers.dart';
import 'package:price_tracker/widgets/crypto_list_tile.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MarketProvider>(
        builder: (_, marketProvider, child) {
          List<CoingekoModel> favorites = marketProvider.markets
              .where((element) => element.isFavorite == true)
              .toList();

          if (favorites.isNotEmpty) {
            return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (_, index) =>
                    CryptoListTile(coingekoModel: favorites[index]));
          } else {
            return const Center(
              child: Text("No Favorite Crypto Yet"),
            );
          }
        },
      ),
    );
  }
}
