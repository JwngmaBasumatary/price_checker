import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:price_tracker/constants/themes.dart';
import 'package:price_tracker/pages/home_page.dart';
import 'package:price_tracker/providers/market_providers.dart';
import 'package:price_tracker/providers/theme_provider.dart';
import 'package:price_tracker/services/shared_preferences_storage.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme= await SharedPreferenceStorage.getTheme() ?? "light";
  runApp( MyApp(theme: currentTheme,));
}

class MyApp extends StatelessWidget {
  final String theme;
  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(create: (_) => MarketProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider(theme)),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child){
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            //1. call BotToastInit
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
          );
        },

      ),
    );
  }
}
