import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/model/camera_manager.dart';
import 'package:plant_ai/model/model.dart';
import 'package:plant_ai/view/home_page.dart';
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
  late Future<void> _initializeControllerFuture;

  Future<void> onPressed() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController.takePicture();
      Uint8List bytes = await image.readAsBytes();

      File imageFile = File(image.path);
      Model().updateFile(imageFile);
      Model.runInference(bytes);

      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          // ignore: prefer_const_constructors
          builder: (context) => HomeScreen(
            currentTabIndex: 1,
          ),
        ),
      );
    } catch (e) {
      if (e is CameraException) {
        debugPrint("Error occurred while taking picture $e");
      } else {
        debugPrint("Unknown error occurred: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _cameraController.initialize();
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
    print("height : $height");
    return FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: double.infinity,
                  width: width,
                  child: CameraPreview(_cameraController),
                ),
                Positioned(
                    child: Center(
                  child: Container(
                    width: width / 1.5, // Largeur du cadre
                    height: height / 2.7, // Hauteur du cadre
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(20), // Rayon des coins arrondis
                      border: Border.all(
                        color: Colors.white, // Couleur blanche pour la bordure
                        width: 4, // Épaisseur de la bordure
                      ),
                    ),
                  ),
                )),
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
                          const Gallery(),
                          RawMaterialButton(
                            onPressed: () async {
                              await onPressed();
                            },
                            elevation: 2.0,
                            fillColor: Colors.white,
                            padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                            child: const CircleAvatar(
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
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
