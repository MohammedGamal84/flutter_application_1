import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/auth/services/api_constants.dart';
import 'package:flutter_application_1/auth/services/api_service.dart';

class AdminService {
  final ApiService _apiService = ApiService();

  // ================= ADD HOTEL =================

  Future<void> addHotel({
    required String userId,
    required String name,
    required String description,
    required String rate,
    required String price,
    required String location,
    required String availableRooms,
    required String availableTimes,
    required File imageCover,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "description": description,
        "rate": rate,
        "price": price,
        "location": location,
        "availableRooms": availableRooms,
        "availableTimes": availableTimes,
        "imageCover": await MultipartFile.fromFile(
          imageCover.path,
          filename: imageCover.path.split('/').last,
        ),
      });
      final response = await _apiService.dio.post(
        "/hotels/createHotel",
        queryParameters: {
          "userId": userId,
        },
        data: formData,
      );

      print("ADD HOTEL RESPONSE: ${response.data}");
    } catch (e) {
      print("ADD HOTEL ERROR: $e");
      rethrow;
    }
  }

  // ================= ADD LOCATION =================

  Future<void> addLocation({
    required String userId,
    required String name,
    required String city,
    required String country,
  }) async {
    try {
      final response = await _apiService.dio.post(
        "/locations/createLocation",
        queryParameters: {
          "userId": userId,
        },
        data: {
          "name": name,
          "city": city,
          "country": country,
        },
      );

      print("ADD LOCATION RESPONSE: ${response.data}");
    } catch (e) {
      print("ADD LOCATION ERROR: $e");
      rethrow;
    }
  }
 // ================= ADD HOME =================

Future<void> addHome({
  required String userId,
  required String title,
  required String description,
  required String rate,
  required String price,
  required String location,
  required String features,
  required File imageCover,
}) async {

  try {

    FormData formData = FormData.fromMap({

  "title": title,
  "description": description,
  "rate": rate,
  "price": price,
  "location": location,
  "features": features,

  "imageCover": await MultipartFile.fromFile(
    imageCover.path,
    filename: imageCover.path.split('/').last,
  ),
});

    final response = await _apiService.dio.post(
      "/homes/createHome",

      queryParameters: {
        "userId": userId,
      },

      data: formData,
    );

    print("ADD HOME RESPONSE: ${response.data}");

  } on DioException catch (e) {

    print("STATUS CODE:");
    print(e.response?.statusCode);

    print("RESPONSE DATA:");
    print(e.response?.data);

    rethrow;
  }
}
// ================= DELETE HOME =================

Future<void> deleteHome({
  required String userId,
  required String homeId,
}) async {
  try {
    final response = await _apiService.dio.delete(
      "${ApiConstants.baseUrl}${ApiConstants.deleteHome}",
      queryParameters: {
        "userId": userId,
        "id": homeId,
      },
    );

    print("DELETE HOME RESPONSE: ${response.data}");
  } catch (e) {
    print("DELETE HOME ERROR: $e");
    rethrow;
  }
}

// ================= DELETE HOTEL =================

Future<void> deleteHotel({
  required String userId,
  required String hotelId,
}) async {
  try {
    final response = await _apiService.dio.delete(
      "${ApiConstants.baseUrl}${ApiConstants.deleteHotel}",
      queryParameters: {
        "userId": userId,
        "id": hotelId,
      },
    );

    print("DELETE HOTEL RESPONSE: ${response.data}");
  } catch (e) {
    print("DELETE HOTEL ERROR: $e");
    rethrow;
  }
}

// ================= DELETE LOCATION =================

Future<void> deleteLocation({
  required String userId,
  required String locationId,
}) async {
  try {
    final response = await _apiService.dio.delete(
      "${ApiConstants.baseUrl}${ApiConstants.deleteLocation}",
      queryParameters: {
        "userId": userId,
        "id": locationId,
      },
    );

    print("DELETE LOCATION RESPONSE: ${response.data}");
  } catch (e) {
    print("DELETE LOCATION ERROR: $e");
    rethrow;
  }
}
}