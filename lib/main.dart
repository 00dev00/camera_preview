import 'package:camera_preview/views/screens/home.dart';
import 'package:flutter/material.dart';

const appName = "Camera preview";
final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightGreenAccent,
  ),
);

void main() {
  runApp(
    MaterialApp(
      title: appName,
      themeMode: ThemeMode.system,
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // без этой строки при появлении экранной кливиатуры
        // MediaQuery.of(context).viewInsets.bottom всегда равнялся нулю
        // вне зависимости от того, какой контекст передавался
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(appName),
        ),
        body: const HomeScreen(),
      ),
    ),
  );
}
