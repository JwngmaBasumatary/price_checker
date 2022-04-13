import 'package:flutter/material.dart';
import 'package:price_tracker/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'favorites_page.dart';
import 'market_page.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
    Provider.of<ThemeProvider>(context, listen: false);
    return SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            children: [
              /*   const Text(
              "Crypto Today",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const SizedBox(
              height: 20,
            ),*/
              TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Text(
                      "Market",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Favorites",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ]),
              Expanded(
                child: TabBarView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    controller: tabController,
                    children: const [MarketPage(), FavoritesPage()]),
              )
            ],
          ),
        ));
  }
}
