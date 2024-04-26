import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraManager {
  static late CameraController _cameraController;
  static late List<CameraDescription> cameras;

  static Future<CameraDescription> openCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final camera = cameras.first;
    // _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    // await _cameraController.initialize();
    return camera;
  }

  static Future<void> stop() async {
    _cameraController.dispose();
  }

  static CameraController get cameraController => _cameraController;
}
