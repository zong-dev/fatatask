import 'dart:convert';

import 'package:fasta/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class UserProvider with ChangeNotifier {
  String? email;
  String? token;
  String? username;
  int? id;
  String? createdAt;

  static String baseUri = "https://reqres.in/api";
  bool isLoading = false;

  UserProvider({this.email, this.username, this.token});
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  void setAuthData({
    required String email,
    required String token,
  }) async {
    this.email = email;
    this.token = token;
    notifyListeners();
  }

  Future<AuthStatus> getAuthStatus() async {
    String? token = await storage.read(key: "auth_token");
    if (token == null || token.isEmpty) {
      return AuthStatus.unauthenticated;
    } else {
      this.token = token;
      return AuthStatus.authenticated;
    }
  }

  changeLoadingStatus() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<bool?> createAccount({
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      if (isLoading) return null;
      isLoading = true;

      Response response = await post(Uri.parse("$baseUri/register"), body: {
        "email": email,
        "password": password,
      });
      
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        username = fullname;
        id = data['id'];
        await storage.write(key: "auth_token", value: data['token']);
        token = data['token'];
        username = fullname;
        changeLoadingStatus();
        return true;
      }
      print("Register Response: $data" );
      changeLoadingStatus();
      return false;
    } catch (e) {
      changeLoadingStatus();
      print("Register Error: " + e.toString());
      return false;
    }
  }

  Future loginToAccount({
    required String email,
    required String password,
  }) async {
    if (isLoading) return null;
    changeLoadingStatus();
    try {
      Response response = await post(Uri.parse("$baseUri/login"), body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await storage.write(key: "auth_token", value: data['token']);
        token = data['token'];
        changeLoadingStatus();
        return true;
      }
      changeLoadingStatus();
      return false;
    } catch (e) {
      changeLoadingStatus();
      print("Login Error" + e.toString());
      return false;
    }
  }

  Future<bool?> updateAccountData({
    required String email,
    required String fullname,
  }) async {
    if (isLoading) return null;
    changeLoadingStatus();
    try {
      Response response = await post(Uri.parse("$baseUri/users/$id"), body: {
        "name": fullname,
        "job": "user",
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        username = data['name'];
        changeLoadingStatus();
        return true;
      }

      return false;
    } catch (e) {
      changeLoadingStatus();
      print("Update Error: " + e.toString());
      return false;
    }
  }
}
