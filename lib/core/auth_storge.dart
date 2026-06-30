import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {

  static Future<void> saveUserData({
    required String token,
    required String userId,
    required String role,
  }) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("token", token);
    await prefs.setString("userId", userId);
    await prefs.setString("role", role);
  }

  static Future<String?> getToken() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("token");
  }
  static Future<void> saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("userId", userId);
}

  static Future<String?> getUserId() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("userId");
  }

  static Future<String?> getRole() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("role");
  }

  static Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}