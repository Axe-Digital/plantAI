import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    _cameras = await availableCameras();
  } catch (e) {
    print(e);
  }
  runApp(const MaterialApp(
    home: CameraApp(),
  ));
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller.initialize().then((_) {
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          child: CameraPreview(controller),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  margin: EdgeInsets.all(20),
                  child: MaterialButton(
                    onPressed: () async {
                      if (!controller.value.isInitialized) {
                        return;
                      }
                      if (controller.value.isTakingPicture) {
                        return;
                      }

                      try {
                        await controller.setFlashMode(FlashMode.auto);
                        XFile file = await controller.takePicture();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImagePreview(file)));
                      } on CameraException catch (e) {
                        debugPrint("Error occured while taking picture $e");
                      }
                    },
                    color: Colors.white,
                    child: Text("Take a picture"),
                  )),
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
