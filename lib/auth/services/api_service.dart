import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_constants.dart';

class ApiService {

  late Dio dio;

  static final GlobalKey<NavigatorState>
      navigatorKey =
      GlobalKey<NavigatorState>();

  ApiService() {

    dio = Dio(

      BaseOptions(

        baseUrl:
            ApiConstants.baseUrl,

        connectTimeout:
            const Duration(seconds: 15),

        receiveTimeout:
            const Duration(seconds: 15),

        headers: {
          "Accept":
              "application/json",
        },
      ),
    );

    dio.interceptors.add(

      InterceptorsWrapper(

        // 🔥 إضافة التوكن
        onRequest: (
          options,
          handler,
        ) async {

          final prefs =
              await SharedPreferences
                  .getInstance();

          final token =
              prefs.getString(
            "token",
          );

          if (token != null) {

            options.headers[
                    "Authorization"] =
                "Bearer $token";
          }

          return handler.next(
            options,
          );
        },

        // 🔥 لو التوكن انتهى
        onError: (
          e,
          handler,
        ) async {

          if (e.response?.statusCode ==
              401) {

            final prefs =
                await SharedPreferences
                    .getInstance();

            await prefs.remove(
              "token",
            );

            await prefs.remove(
              "role",
            );

            navigatorKey.currentState
                ?.pushAndRemoveUntil(

              MaterialPageRoute(
                builder: (_) =>
                    const AuthScreen(),
              ),

              (route) => false,
            );
          }

          return handler.next(e);
        },
      ),
    );
  }
}