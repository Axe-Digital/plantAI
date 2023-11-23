import 'dart:io' as io;
// import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraManager {
  static late CameraController _cameraController;

  static Future<CameraDescription> openCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final camera = cameras.first;
    // _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    // await _cameraController.initialize();
    return camera;
  }

  static CameraController get cameraController => _cameraController;

}
