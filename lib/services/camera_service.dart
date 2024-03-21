import 'package:camera/camera.dart';

final class CameraService {
  late final List<CameraDescription> _cameras;
  late final CameraController cameraController;

  static final CameraService _sharedInstance = CameraService._();
  factory CameraService() => _sharedInstance;

  CameraService._();

  Future<void> init() async {
    try {
      _cameras = await availableCameras();
    } on CameraException {
      _cameras = [];
    }

    cameraController = CameraController(
      // в задании не сказано какую камеру использовать,
      // поэтому берем первую в списке (основную)
      _cameras[0],
      ResolutionPreset.max,
    );

    await cameraController.initialize();
  }
}
