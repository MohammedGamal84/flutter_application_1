import 'package:dio/dio.dart';
import 'package:flutter_application_1/auth/services/api_service.dart';
import 'package:flutter_application_1/core/auth_storge.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthService {

  final ApiService _apiService = ApiService();

  /// LOGIN
 Future<Map<String, dynamic>> login({
  required String email,
  required String password,
}) async {

  try {

    final response = await _apiService.dio.post(
      '/auth/login',
      data: {
        "email": email,
        "password": password,
      },
    );

    print("======================");
    print("STATUS CODE:");
    print(response.statusCode);

    print("======================");
    print("DATA:");
    print(response.data);

    print("======================");
    print("HEADERS:");
    print(response.headers);

    print("======================");

    final data = response.data;

    return Map<String, dynamic>.from(data);

  } on DioException catch (e) {

    print("DIO ERROR:");
    print(e.response?.data);
    print(e.response?.statusCode);

    throw Exception(
      e.response?.data.toString() ?? "Login failed",
    );

  } catch (e) {

    print("NORMAL ERROR:");
    print(e);

    rethrow;
  }
}

  /// SIGNUP
  Future<Map<String, dynamic>> signup({
    required String userName,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {

    final response = await _apiService.dio.post(
      '/auth/signup',
      data: {
        "userName": userName,
        "email": email,
        "password": password,
        "passwordConfirm": passwordConfirm,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  /// Forgot Password
  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {

    final response = await _apiService.dio.post(
      '/auth/forgotPassword',
      data: {
        "email": email,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  /// Reset Password
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirm,
  }) async {

    final response = await _apiService.dio.post(
      '/auth/resetPassword',
      data: {
        "email": email,
        "code": code,
        "password": password,
        "passwordConfirm": passwordConfirm,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  /// LOGOUT
  Future<void> logout() async {

    await AuthStorage.logout();
  }

  /// GET TOKEN
 Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}
}


