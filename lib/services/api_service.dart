import 'package:camera_preview/models/camera_info.dart';
import 'package:dio/dio.dart';

final class ApiService {
  static final _client = Dio(
    BaseOptions(
      baseUrl: "https://pyshop-flutter-test.free.beeceptor.com",
      sendTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Future<(bool success, String message)> sendInfo(
      CameraInfo cameraInfo) async {
    if (cameraInfo.comment.isEmpty) {
      Future.error("Comment is missing");
    }

    final formData = FormData.fromMap(
      {
        'comment': cameraInfo.comment,
        'latitude': cameraInfo.latitude,
        'longitude': cameraInfo.longitude,
        'photo': await MultipartFile.fromFile(cameraInfo.photo.path),
      },
    );

    try {
      final response = await _client.post(
        "/upload_photo",
        data: formData,
      );

      // эндпоинт сконфигурировал таким образом,
      // чтобы в случае положительного ответа
      // возвращался JSON с единственным полем status
      return (true, response.data["status"] as String);
    } on DioException {
      return (false, "Failed to send image");
    }
  }
}
