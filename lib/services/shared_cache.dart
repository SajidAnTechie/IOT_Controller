import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iotcontroller/model/user.dart';
import 'package:iotcontroller/config/appConfig.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

class SharedCache {
  static Future<bool> isKeyExit(String key) async {
    final isKeyExit = await APICacheManager().isAPICacheKeyExist(key);

    return isKeyExit;
  }

  static Future<UserModel> getLoginDetails(BuildContext context) async {
    final isLoggedIn = await isKeyExit(Config.apiCachedLoginKey);

    if (!isLoggedIn) {
      await logout(context);
      return null;
    }
    final loginDetails =
        await APICacheManager().getCacheData(Config.apiCachedLoginKey);
    return loginResponseJson(loginDetails.syncData);
  }

  static Future<UserModel> getCachedData(
      Function convertToJson, String key) async {
    final loginDetails = await APICacheManager().getCacheData(key);
    return convertToJson(loginDetails.syncData);
  }

  static Future<void> setLoginDetails(UserModel model) async {
    final cachedData = APICacheDBModel(
        key: Config.apiCachedLoginKey, syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cachedData);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache(Config.apiCachedLoginKey);

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
