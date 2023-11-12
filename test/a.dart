// import 'package:tflite_flutter/tflite_flutter.dart';

// void main() {
//   // Chargement du modèle
//   Interpreter interpreter = Interpreter.fromAsset('model.tflite');

//   // Chargement de l'image
//   Image image = Image.asset('image.jpg');

//   // Conversion de l'image en format compréhensible par le modèle
//   List<int> imageData = image.toByteData().buffer.asUint8List();

//   // Analyse de l'image
//   List<double> predictions = interpreter.run(imageData);

//   // Affichage des résultats
//   print(predictions);
// }