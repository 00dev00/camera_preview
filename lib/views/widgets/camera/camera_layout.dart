import 'package:camera_preview/services/camera_service.dart';
import 'package:camera_preview/views/widgets/camera/camera_frame.dart';
import 'package:flutter/material.dart';

abstract class CameraLayout extends StatelessWidget {
  CameraLayout({super.key, required this.onButtonPress});

  final cameraService = CameraService();
  final Future<void> Function(BuildContext, String) onButtonPress;
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<Widget> getForm(BuildContext context) {
    return [
      Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
      ),
      const SizedBox(
        height: 15,
      ),
      ElevatedButton.icon(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            await onButtonPress(
              context,
              textController.text,
            );
          }
        },
        icon: const Icon(Icons.camera_alt),
        label: const Text("Take a shot"),
      )
    ];
  }
}

final class CameraHorizontalLayout extends CameraLayout {
  CameraHorizontalLayout({
    super.key,
    required super.onButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Flexible(
          flex: 3,
          child: CameraFrame(),
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: getForm(context),
          ),
        ),
      ],
    );
  }
}

final class CameraVerticalLayout extends CameraLayout {
  CameraVerticalLayout({
    super.key,
    required super.onButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.7 -
              MediaQuery.of(context).viewInsets.bottom,
          width: double.infinity,
          child: const CameraFrame(),
        ),
        Column(
          children: getForm(context),
        ),
      ],
    );
  }
}
