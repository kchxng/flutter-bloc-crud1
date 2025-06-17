import 'dart:convert';

import 'package:ticketbooking_app/core/error/exceptions.dart';
import 'package:ticketbooking_app/core/utils/constants.dart';
import 'package:ticketbooking_app/modules/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String username, String password) async {
    final res = await client.get(
      Uri.parse('${Constants.baseUrl}/users/1'),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      return UserModel.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }
}
