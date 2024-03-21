import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraSnapshot extends StatelessWidget {
  const CameraSnapshot({
    super.key,
    required this.cameraController,
    required this.tapAction,
  });

  final CameraController cameraController;
  final VoidCallback? tapAction;

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
                  cameraController,
                ),
              );
            }),
          ),
        ),
        Form(
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
                  onPressed: tapAction,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Take a shot"),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
