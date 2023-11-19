import 'dart:io' as io;
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:tflite_flutter/tflite_flutter.dart';

class Model with ChangeNotifier{
  static List<io.File> imageList = [];
  static late String? _plantHealth;
  static String? get getPlantHealth => _plantHealth;
  static set setPlantHealth(String? x) => x;
  static late Uint8List imageData;
  static late Interpreter interpreter;
  static late List<double> output;
  static late Tensor inputTensor;
  static late Tensor outputTensor;
  static const String modelPath = "assets/model/model.tflite";

  static Future<void> initialize() async {
    final options = InterpreterOptions();
    // Load model from assets
    interpreter = await Interpreter.fromAsset(modelPath, options: options);
    inputTensor = interpreter.getInputTensors().first;
    outputTensor = interpreter.getOutputTensors().first;
  }

  Future<void> updateFile(io.File file) async {
    imageList.add(file);
      notifyListeners();
  }
}
