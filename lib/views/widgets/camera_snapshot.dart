import 'package:camera/camera.dart';
import 'package:camera_preview/models/camera_info.dart';
import 'package:camera_preview/services/api_service.dart';
import 'package:camera_preview/services/camera_service.dart';
import 'package:camera_preview/services/geo_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CameraSnapshot extends StatelessWidget {
  CameraSnapshot({super.key});

  final cameraService = CameraService();
  final geoService = GeoService();

  @override
  Widget build(BuildContext context) {
    final windowHeight = MediaQuery.sizeOf(context).height;

    return (windowHeight > 600) ? _getVerticalLayout() : _getHorizontalLayout();
  }

  Widget _getHorizontalLayout() {
    return const Row(
      children: [
        Center(),
      ],
    );
  }

  Future<void> _onButtonPress(BuildContext context, String comment) async {
    var scaffoldMessanger = ScaffoldMessenger.of(context);
    var theme = Theme.of(context);

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

  Widget _getVerticalLayout() {
    final textController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final borderRadius = BorderRadius.circular(10);

    return Column(
      children: [
        Padding(
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
            child: Builder(builder: (context) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.7 -
                    MediaQuery.of(context).viewInsets.bottom,
                width: double.infinity,
                child: CameraPreview(
                  cameraService.controller,
                ),
              );
            }),
          ),
        ),
        Builder(builder: (context) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    15,
                    0,
                    15,
                    10,
                  ),
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.edit),
                      hintText: "Put a comment here",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Comment must not be null or empty";
                      }

                      return null;
                    },
                  ),
                ),
                Tooltip(
                  message: "Snapshot will be sent to the server",
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await _onButtonPress(
                          context,
                          textController.text,
                        );
                      }
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Take a shot"),
                  ),
                ),
              ],
            ),
          );
        })
      ],
    );
  }
}
