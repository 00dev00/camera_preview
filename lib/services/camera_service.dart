import 'package:camera/camera.dart';

// все сервисы реализую синглтонами,
// так как нет смысла создавать отдельные копии
// для выполнения однотипных запросов
final class CameraService {
  late final List<CameraDescription> _cameras;
  late final CameraController controller;
  bool _serviceInitialized = false;

  static final CameraService _sharedInstance = CameraService._();
  factory CameraService() => _sharedInstance;

  CameraService._();

  Future<void> init() async {
    // guard clause для hot reload'a
    if (!_serviceInitialized) {
      _cameras = await availableCameras();
      controller = CameraController(
        // в задании не сказано какую камеру использовать,
        // поэтому берем первую в списке (основную)
        _cameras[0],
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await controller.initialize();
      _serviceInitialized = true;
    }
  }

  Future<XFile> getSnapshot() async {
    await init();
    final image = await controller.takePicture();

    return image;
  }
}
