import 'dart:io' as io;
// import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

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

  Future<io.File> testCompressAndGetFile(
      io.File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );
    return io.File(result!.path);
  }
}
