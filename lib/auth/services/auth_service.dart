import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.dio.post(
        '/auth/login',
        data: {
          "email": email.trim(),
          "password": password,
        },
      );

      final data = _mapResponse(response);

      if (data["token"] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"].toString());
      }

      return data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع");
    }
  }

  Future<Map<String, dynamic>> signup({
    required String userName,
    required String email,
    required String password,
    required String passwordConfirm,
    String role = "user",
  }) async {
    try {
      final response = await _apiService.dio.post(
        '/auth/signup',
        data: {
          "userName": userName.trim(),
          "email": email.trim(),
          "password": password,
          "passwordConfirm": passwordConfirm,
          "role": role,
        },
      );

      final data = _mapResponse(response);

      if (data["token"] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"].toString());
      }

      return data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع");
    }
  }

  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _apiService.dio.post(
        '/auth/forgotPassword',
        data: {
          "email": email.trim(),
        },
      );

      return _mapResponse(response);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع");
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await _apiService.dio.post(
        '/auth/resetPassword/142d0360345bd5016be56f8e3b1365fb79de816c70de6162b2b4bcc5fd76f72e',
        data: {
          "email": email.trim(),
          "code": code.trim(),
          "password": password,
          "passwordConfirm": passwordConfirm,
        },
      );

      return _mapResponse(response);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Map<String, dynamic> _mapResponse(Response response) {
    if (response.data is Map<String, dynamic>) {
      return Map<String, dynamic>.from(response.data);
    }

    return {
      "message": "تمت العملية بنجاح",
    };
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      final responseData = e.response?.data;

      if (responseData is Map<String, dynamic>) {
        if (responseData["message"] != null) {
          return responseData["message"].toString();
        }

        if (responseData["error"] != null) {
          return responseData["error"].toString();
        }
      }

      return "Server error: ${e.response?.statusCode}";
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "انتهت مهلة الاتصال بالسيرفر";

      case DioExceptionType.connectionError:
        return "فشل الاتصال بالسيرفر";

      case DioExceptionType.badCertificate:
        return "مشكلة في شهادة الأمان";

      case DioExceptionType.cancel:
        return "تم إلغاء الطلب";

      case DioExceptionType.unknown:
        return "تحقق من الإنترنت أو من تشغيل السيرفر";

      default:
        return "حدث خطأ في الاتصال";
    }
  }
}