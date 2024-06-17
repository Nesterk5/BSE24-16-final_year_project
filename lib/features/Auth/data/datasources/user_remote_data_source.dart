import 'dart:convert';

import 'package:final_year/features/Auth/data/models/user_model.dart';
import 'package:final_year/utils/constants.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> loginUser(String login, String password);
  Future<bool> logoutUser();
  Future<bool> signupUser(
      String name, String phone, String password, String email);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  @override
  Future<UserModel> loginUser(String login, String password) async {
    final client = OdooClient(DATABASE_URL);
    print("here logging in.....");
    print(login);
    print(password);
    final session = await client.authenticate(DATABASE_NAME, login, password);
    print('now now ${client.sessionId}');

    var response = await client.callKw(
      {
        'model': 'res.users',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'domain': [
            ['id', '=', session.userId],
          ],
          'fields': [
            'id',
            'login',
            'name',
            'phone',
          ],
        }
      },
    );

    print(response);
    var user = response[0];

    UserModel userModel = UserModel(
      id: user['id'],
      login: user['login'],
      name: user['name'],
      password: password,
      phone: user['phone'] != false ? user['phone'] : "",
    );

    await saveUserToLocalStorage(userModel)
        .timeout(const Duration(seconds: 360));

    return userModel;
  }

  @override
  Future<bool> signupUser(
      String name, String phone, String password, String email) async {
    print("registering....");

    final client = OdooClient(DATABASE_URL);

    final session =
        await client.authenticate(DATABASE_NAME, USERNAME, PASSWORD);

    var response = await client.callKw({
      'model': 'res.users',
      'method': 'create',
      'args': [
        {
          'login': phone,
          'active': true,
          'password': password,
          'name': name,
          'email': email
        }
      ],
      'kwargs': {},
    }).timeout(const Duration(seconds: 120));
    print(response);
    return true;
  }

  @override
  Future<bool> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.remove('user');
    if (!result) {
      throw Exception();
    }
    return true;
  }

  Future saveUserToLocalStorage(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
    await prefs.setString('userLogin', user.login);
    await prefs.setString('userPassword', user.password);
  }
}
