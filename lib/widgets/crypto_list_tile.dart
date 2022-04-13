import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_tracker/models/coingeko_model.dart';
import 'package:price_tracker/pages/details_page.dart';
import 'package:price_tracker/providers/market_providers.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  final CoingekoModel coingekoModel;

  const CryptoListTile({Key? key, required this.coingekoModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return Card(
      color: Colors.grey,
      elevation: 1,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Detailspage(
                    id: coingekoModel.id!,
                  )));
        },
        contentPadding: const EdgeInsets.all(0),
        title: Row(
          children: [
            Flexible(
              child: Text(
                    coingekoModel.name!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 0,
            ),
            GestureDetector(
              onTap: () {
                if (coingekoModel.isFavorite == false) {
                  marketProvider.addFavorite(coingekoModel);
                } else {
                  marketProvider.removeFavorite(coingekoModel);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  coingekoModel.isFavorite
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  size: 15,
                  color: coingekoModel.isFavorite ? Colors.red : Colors.white,
                ),
              ),
            )
          ],
        ),
        subtitle: Text(coingekoModel.symbol!.toUpperCase()),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹ " + coingekoModel.currentPrice!.toStringAsFixed(2),
                style: const TextStyle(color: Colors.indigo),
              ),
              Builder(builder: (_) {
                num priceChange = coingekoModel.priceChange24h!;
                num priceChangePercentage =
                    coingekoModel.priceChangePercentage24h!;

                if (priceChange < 0) {
                  return Text(
                    "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})",
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Text(
                    "+${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})",
                    style: const TextStyle(color: Colors.green),
                  );
                }
              })
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.indigo,
            backgroundImage: NetworkImage(coingekoModel.image!),
          ),
        ),
      ),
    );
  }
}
