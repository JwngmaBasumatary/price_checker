import 'package:flutter/material.dart';
import 'package:price_tracker/constants/tools.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var displayName = " Jwngma Basumatary";
  var profilePhoto =
      "https://cryptologos.cc/logos/wrapped-bitcoin-wbtc-logo.png?v=022";

  List<Map<dynamic, dynamic>> navList = [
    {
      "title": "Profile",
      "icon": const Icon(
        Icons.person,
        color: Colors.blue,
      ),
      "routeName": ""
    },
    {
      "title": "My Wallet",
      "icon": const Icon(
        Icons.account_balance_wallet,
        color: Colors.blue,
      ),
      "routeName": ""
    },
    {
      "title": "My Statistic",
      "icon": const Icon(
        Icons.insert_chart,
        color: Colors.blue,
      ),
      "routeName": ""
    },
    {
      "title": "Top Players",
      "icon": const Icon(
        Icons.emoji_events,
        color: Colors.blue,
      ),
      "routeName": ""
    },
    {
      "title": "Notifications",
      "icon": const Icon(
        Icons.notifications_active,
        color: Colors.blue,
      ),
      "routeName": ""
    },
    {
      "title": "Help",
      "icon": const Icon(
        Icons.help,
        color: Colors.blue,
      ),
      "routeName": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                Positioned(
                  bottom: -40,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFFBBD10),
                        backgroundImage: NetworkImage(profilePhoto),
                        radius: 45.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                displayName,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "smkbty@gmail.com",
                style: TextStyle(
                    fontSize: 12.0, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: navList.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Tools.showToasts("${navList[index]['title']} has been Clicked");
                    },
                    child: Card(
                      color: Colors.white70,
                      child: ListTile(
                        leading: navList[index]['icon'],
                        title: Text(navList[index]['title'].toString()),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Tools.showToasts("The Logout Button has been Clicked");
                },
                child: const Text("Log Out")),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

}
