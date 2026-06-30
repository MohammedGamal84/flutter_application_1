import 'package:flutter_application_1/auth/services/api_constants.dart';


class ImageHelper {
  static String getFullImageUrl(String path) {
    if (path.isEmpty) return '';

    if (path.startsWith('http')) {
      return path;
    }

    return "${ApiConstants.imageBaseUrl}$path";
  }
}