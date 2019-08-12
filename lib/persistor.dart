import 'dart:convert';

import 'package:flutter_app_2/model/fueling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Persistor {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const String KEY = 'DATA';

  Future<List<Fueling>> load() async {
    var prefs = await _prefs;

    if (prefs.getKeys().contains(KEY)) {
      final deserialized = json.decode(prefs.getString(KEY)) as List<dynamic>;
      return deserialized.map((obj) => Fueling.fromJson(obj)).toList();
    }

    print([]);

    return [];
  }

  void save(List<Fueling> data) async {
    var serialized = json.encode(data);

    var prefs = await _prefs;
    prefs.setString(KEY, serialized);
  }
}