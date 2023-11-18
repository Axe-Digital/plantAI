import 'package:camera/camera.dart';

class CameraManager {
  static late CameraController _cameraController;

  static Future<void> initialize() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
  }

  static CameraController get cameraController => _cameraController;
  

}
