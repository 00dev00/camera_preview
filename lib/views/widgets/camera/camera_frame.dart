import 'package:camera/camera.dart';
import 'package:camera_preview/services/camera_service.dart';
import 'package:flutter/widgets.dart';

class CameraFrame extends StatelessWidget {
  const CameraFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);
    final cameraService = CameraService();

    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 20),
      child: Container(
          clipBehavior: Clip.antiAlias,
          foregroundDecoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: borderRadius,
          ),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          child: CameraPreview(
            cameraService.controller,
          )),
    );
  }
}
