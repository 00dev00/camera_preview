import 'package:camera/camera.dart';

class CameraInfo {
  final String comment;
  final double latitude;
  final double longitude;
  final XFile photo;

  CameraInfo({
    required this.comment,
    required this.latitude,
    required this.longitude,
    required this.photo,
  });
}
