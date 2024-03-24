import 'package:camera/camera.dart';
import 'package:camera_preview/models/camera_info.dart';
import 'package:camera_preview/services/api_service.dart';
import 'package:camera_preview/services/camera_service.dart';
import 'package:camera_preview/services/geo_service.dart';
import 'package:camera_preview/views/widgets/camera/camera_layout.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CameraSnapshot extends StatelessWidget {
  CameraSnapshot({super.key});

  final cameraService = CameraService();
  final geoService = GeoService();

  @override
  Widget build(BuildContext context) {
    final windowHeight = MediaQuery.sizeOf(context).height;

    return (windowHeight > 400)
        ? CameraVerticalLayout(
            onButtonPress: _onButtonPress,
          )
        : CameraHorizontalLayout(
            onButtonPress: _onButtonPress,
          );
  }

  Future<void> _onButtonPress(BuildContext context, String comment) async {
    var scaffoldMessanger = ScaffoldMessenger.of(context);
    var theme = Theme.of(context);

    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final XFile image = await cameraService.getSnapshot();
      final Position position = await geoService.getCurrentPosition();

      final cameraInfo = CameraInfo(
        comment: comment,
        latitude: position.latitude,
        longitude: position.longitude,
        photo: image,
      );

      var (success, message) = await ApiService.sendInfo(cameraInfo);

      final snackBar = SnackBar(
        backgroundColor: success
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.error,
        content: Text(
          message,
          style: TextStyle(
            color: success
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onError,
          ),
        ),
      );
      scaffoldMessanger.showSnackBar(snackBar);
    } on CameraException {
      const snackBar = SnackBar(
        content: Text("Camera failed to take a snapshot"),
      );

      scaffoldMessanger.showSnackBar(snackBar);
    } on Exception catch (ex) {
      final snackBar = SnackBar(
        content: Text(ex.toString()),
      );
      scaffoldMessanger.showSnackBar(snackBar);
    }
  }
}
