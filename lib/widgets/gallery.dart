import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:plant_ai/view/home_page.dart';
import 'package:plant_ai/view/plant_page.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:plant_ai/model/model.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  io.File? imageFile;

  @override
  void initState() {
    super.initState();
    Model.initialize();
  }

  Future<void> loadImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        imageFile = io.File(pickedImage.path);
        Model.imageData = imageFile!.readAsBytesSync();
        Model.imageData = Uint8List.fromList(Model.imageData);
        Model().updateFile(imageFile!);
      });
    }
    await runInference(Model.imageData);
  }

  Future<void> runInference(Uint8List inputImageData) async {
    // Resize image
    img.Image? image = img.decodeImage(inputImageData);
    img.Image? resizedImage = img.copyResize(image!,
        width: Model.inputTensor.shape[1], height: Model.inputTensor.shape[2]);

    // Prepare input
    final imageMatrix = List.generate(
      resizedImage.height,
      (y) => List.generate(
        resizedImage.width,
        (x) {
          final pixel = resizedImage.getPixel(x, y);
          // Value between 0 to 1 per channel
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        },
      ),
    );

    final input = [imageMatrix];
    final output = [List<double>.filled(Model.outputTensor.shape[1], 0.0)];

    Model.interpreter.run(input, output);
    List<double> result = output.first;
    print("result ======== $result");

    // Finds the predicted number that corresponds to the highest confidence
    // level of the prediction.
    setState(() {
      if (result[0] < 0.5) {
        Model.setPlantHealth = "La tomate est en bonne sante";
      } else {
        Model.setPlantHealth = "La tomate n'est pas en bonne sante";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // loadImage(ImageSource.gallery).then((value) => Navigator.push(
        //     context, MaterialPageRoute(builder: ((context) => HomeScreen()))));
        loadImage(ImageSource.gallery);
        print(" number ${Model.imageList.length}");
        print("darrel");
      },
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          side: BorderSide(color: Colors.green),
        ),
        backgroundColor: Colors.white,
      ),
      child: const Text(
        "PHOTOS",
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
