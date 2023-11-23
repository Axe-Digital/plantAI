import 'dart:io' as io;
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Model with ChangeNotifier {
  static List<io.File> imageList = [];
  static late String? _plantHealth;
  static String? get getPlantHealth => _plantHealth;
  static set setPlantHealth(String? x) => _plantHealth = x;
  static late Uint8List imageData;
  static late Interpreter interpreter;
  static late List<double> output;
  static late Tensor inputTensor;
  static late Tensor outputTensor;
  static const String modelPath = "assets/model/model.tflite";
  Map<String, double> dataMap = {
    "Analyses effectuées": imageList.length.toDouble(),
  };

  static Future<void> initialize() async {
    final options = InterpreterOptions();
    // Load model from assets
    interpreter = await Interpreter.fromAsset(modelPath, options: options);
    inputTensor = interpreter.getInputTensors().first;
    outputTensor = interpreter.getOutputTensors().first;
  }

  Future<void> updateFile(io.File file) async {
    imageList.add(file);
    print("imageList : ${imageList.length}");
    notifyListeners();
  }

  static Future<void> runInference(Uint8List inputImageData) async {
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
    if (result[0] < 0.5) {
      Model.setPlantHealth = "La tomate n'est pas en bonne sante";
    } else {
      Model.setPlantHealth = "La tomate est en bonne sante";
    }
  }
}
