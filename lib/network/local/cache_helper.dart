import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool?> setData({required String key , required bool value}) async
  {
    print('done');
    return await sharedPreferences?.setBool(key, value);

  }
  static bool? getData({required String key})
  {
    return sharedPreferences?.getBool(key);
  }

  static Future setThemeData({required String key , required int value}) async
  {
    return await sharedPreferences?.setInt(key, value);
  }
  static int? getThemeData({required String key})
  {
    return sharedPreferences?.getInt(key);
  }
}
