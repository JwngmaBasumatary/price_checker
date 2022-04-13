import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceStorage {
  static Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("theme", theme);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currentTheme = await sharedPreferences.getString("theme");
    return currentTheme;
  }

  static Future<bool> addFavorite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favorites = sharedPreferences.getStringList("favorite") ?? [];

    favorites.add(id);

    return await sharedPreferences.setStringList("favorite", favorites);
  }

  static Future<bool> removeFavorite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favorites = sharedPreferences.getStringList("favorite") ?? [];

    favorites.remove(id);

    return await sharedPreferences.setStringList("favorite", favorites);
  }

  static Future<List<String>> getFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("favorite") ?? [];
  }
}
