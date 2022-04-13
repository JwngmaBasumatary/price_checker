import 'package:flutter/material.dart';
import 'package:price_tracker/pages/account_page.dart';
import 'package:price_tracker/pages/homescreen_page.dart';
import 'package:price_tracker/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  var _currentIndex = 0;
  final _screens = [
    const HomeScreenPage(),
    const Scaffold(
      body: Center(
        child: Text("This is Earn page"),
      ),
    ),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Crypto Today",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                themeProvider.toggleTheme();
              },
              icon: themeProvider.themeMode == ThemeMode.light
                  ? const Icon(
                      Icons.light_mode,
                      color: Colors.black,
                    )
                  : const Icon(Icons.light_mode))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          _currentIndex = index;
          setState(() {});
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.earbuds), label: "Earn"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: "Account"),
        ],
      ),
      body: _screens[_currentIndex]

      /*SafeArea(
          child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Column(
          children: [
            */ /*   const Text(
              "Crypto Today",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const SizedBox(
              height: 20,
            ),*/ /*
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
      ))*/
      ,
    );
  }
}
