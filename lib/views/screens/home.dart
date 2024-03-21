import 'package:camera_preview/services/camera_service.dart';
import 'package:camera_preview/views/widgets/camera_snapshot.dart';
import 'package:camera_preview/views/widgets/missing_camera.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final CameraService cameraService;
  VoidCallback? tapAction = () {};

  @override
  void initState() {
    cameraService = CameraService();
    super.initState();
  }

  @override
  void dispose() {
    cameraService.cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cameraService.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const MissingCamera();
          }

          return CameraSnapshot(
            cameraController: cameraService.cameraController,
            tapAction: tapAction,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
