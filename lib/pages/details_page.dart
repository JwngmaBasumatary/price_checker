import 'package:flutter/material.dart';
import 'package:price_tracker/models/chart_model.dart';
import 'package:price_tracker/models/coingeko_model.dart';
import 'package:price_tracker/providers/market_providers.dart';
import 'package:price_tracker/services/api_services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Detailspage extends StatefulWidget {
  final String id;

  const Detailspage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailspageState createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  late TooltipBehavior _tooltipBehavior;

  List<ChartModel> chartList = [];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    ApiServices.getChart(widget.id);
    chartList = prepareList();
    super.initState();
  }

  List<ChartModel> prepareList() {
    List<ChartModel> _chartList = [];

    var datas = [
      [1639713693627, 3647776.370934912],
      [1639717435900, 3655476.470162413],
      [1639720901151, 3635608.209719817],
      [1639724593629, 3617989.286181906],
      [1639728294437, 3579455.629394633],
      [1639731971779, 3596645.5300219664],
      [1639735504440, 3596974.702268038],
      [1639739274274, 3574392.499525909],
      [1639742643513, 3583048.436466221],
      [1639746255010, 3578703.42951887],
      [1639749700800, 3571901.270991449],
      [1639753372031, 3491018.633960291],
      [1639756837428, 3553641.7293028566],
      [1639760425566, 3575802.970900024],
      [1639764200520, 3555669.7941186815],
      [1639767793752, 3564972.5048573026],
      [1639771405996, 3558868.734996458],
      [1639774854719, 3525736.4546907507],
      [1639778429112, 3581438.754909771],
      [1639782342710, 3537047.0113979364],
      [1639785697940, 3523413.180332984],
      [1639789279103, 3530016.373318525],
      [1639793084532, 3485223.471588148],
      [1639796561743, 3489798.0889704386],
      [1639800325023, 3539168.146266915],
      [1639803752264, 3546378.5466376347],
      [1639807349369, 3559002.793724444],
      [1639810831681, 3529149.623821004]
    ];
    for (var data in datas) {
      ChartModel chartModel = ChartModel(data[0], data[1]);
      _chartList.add(chartModel);
    }
    return _chartList;
  }

  @override
  Widget build(BuildContext context) {
    Widget titleAndDetails(
        String title, String details, CrossAxisAlignment crossAxisAlignment) {
      return Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            details,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<MarketProvider>(
          builder: (_, marketProvider, child) {
            CoingekoModel coingekoModel =
                marketProvider.fetchCurrencyById(widget.id);
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchAllCryptocurrencyData();
              },
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(coingekoModel.image!),
                    ),
                    title: Text(
                      coingekoModel.name! +
                          "( ${coingekoModel.symbol!.toUpperCase()})",
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      "₹ " + coingekoModel.currentPrice!.toStringAsFixed(4),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Price Change (24h)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                      Builder(builder: (_) {
                        num priceChange = coingekoModel.priceChange24h!;
                        num priceChangePercentage =
                            coingekoModel.priceChangePercentage24h!;

                        if (priceChange < 0) {
                          return Text(
                            "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 25),
                          );
                        } else {
                          return Text(
                            "+${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(2)})",
                            style: const TextStyle(
                                color: Colors.green, fontSize: 25),
                          );
                        }
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(10)),
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<MarketProvider>(
                        builder: (_, marketProvider, child) {
                          return SfCartesianChart(
                            series: const <ChartSeries<ChartModel, String>>[
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: .1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetails(
                              "Market Cap",
                              "₹ " +
                                  coingekoModel.marketCap!.toStringAsFixed(2),
                              CrossAxisAlignment.start),
                          titleAndDetails(
                              "Market Cap Rank",
                              "#" + coingekoModel.marketCapRank.toString(),
                              CrossAxisAlignment.end),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: .1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetails(
                              "Low 24H",
                              "₹ " + coingekoModel.low24h!.toStringAsFixed(2),
                              CrossAxisAlignment.start),
                          titleAndDetails(
                              "High 24H",
                              coingekoModel.high24h.toString(),
                              CrossAxisAlignment.end),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: .1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetails(
                              "Circulating Supply",
                              coingekoModel.circulatingSupply!
                                  .toStringAsFixed(2),
                              CrossAxisAlignment.start),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: .1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetails(
                              "All Time Low",
                              "₹ " + coingekoModel.atl!.toStringAsFixed(2),
                              CrossAxisAlignment.start),
                          titleAndDetails(
                              "All Time High",
                              coingekoModel.ath.toString(),
                              CrossAxisAlignment.end),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Note- All The Details are taken from coingeko.com",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
