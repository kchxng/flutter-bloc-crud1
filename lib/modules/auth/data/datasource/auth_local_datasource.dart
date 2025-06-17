import 'dart:convert';

import 'package:ticketbooking_app/core/error/exceptions.dart';
import 'package:ticketbooking_app/core/utils/constants.dart';
import 'package:ticketbooking_app/modules/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<UserModel> getCachedUser();
  Future<void> cacheUser(UserModel user);
  Future<void> clearCache();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences sharedPreferences;

  AuthLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getCachedUser() {
    final jsonString = sharedPreferences.getString(Constants.cachedUser);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(UserModel user) {
    return sharedPreferences.setString(
      Constants.cachedUser,
      json.encode(user.toJson()),
    );
  }

// ClearCache or remove localStorage
  @override
  Future<void> clearCache() {
    return sharedPreferences.remove(Constants.cachedUser);
  }
}
