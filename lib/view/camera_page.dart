import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/model/camera_manager.dart';
import 'package:plant_ai/model/model.dart';
import 'package:plant_ai/widgets/gallery.dart';

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  final CameraDescription camera;

  const CameraApp({super.key, required this.camera});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _cameraController = CameraManager.cameraController;

  Future<void> controlleCamera() async {
    if (!_cameraController.value.isInitialized) {
      return;
    }
    if (_cameraController.value.isTakingPicture) {
      return;
    }
    _cameraController.setFlashMode(FlashMode.auto).then((_) {
      return _cameraController.takePicture();
    }).then((XFile file) {
      setState(() {
        File imageFile = File(file.path);
        Model().updateFile(imageFile);
      });
    }).onError((error, stackTrace) {
      if (error is CameraException) {
        debugPrint("Error occurred while taking picture $error");
      } else {
        debugPrint("Unknown error occurred: $error");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);

    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("Access was denied");
            // Handle access errors here.
            break;
          default:
            print(e.description); // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: width,
          child: CameraPreview(_cameraController),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.white,
              width: width,
              // margin: const EdgeInsets.all(20),
              height: height * 0.09,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Gallery(),
                  RawMaterialButton(
                    onPressed: () {
                      controlleCamera();
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 15.0,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: null,
                    child: InkWell(
                      onTap: () {},
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Conseil pour"),
                          Text("les photos "),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ImagePreview extends StatefulWidget {
  XFile file;

  ImagePreview(this.file, {super.key});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    return Scaffold(
      body: Center(child: Image.file(picture)),
    );
  }
}
