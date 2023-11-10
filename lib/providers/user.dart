import 'package:fasta/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider with ChangeNotifier {
  String? email;
  String? token;
  String? username;

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

  Future<bool> createAccount({
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      
      return true;
    } catch (e) {
      return false;
    }
  }

  Future loginToAccount({
    required String email,
    required String password,
  }) async {
    try {
      
    } catch (e) {
      
    }
  }

  Future updateAccountData({
    required String email,
    required String fullname,
  }) async  {
    try {
      
    } catch (e) {
      
    }
  }
  


}
