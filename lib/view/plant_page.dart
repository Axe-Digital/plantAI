import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plant_ai/model/model.dart';

class PlantesScreen extends StatefulWidget {
  const PlantesScreen({
    super.key,
  });

  @override
  State<PlantesScreen> createState() => _PlantesScreenState();
}

class _PlantesScreenState extends State<PlantesScreen> {
  final textEditingTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Builder(
      builder: (context) {
        return Scaffold(
          body: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: width / 44,
                    right: width / 44),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: textEditingTextField,
                    style: const TextStyle(color: Colors.white),
                    maxLines: null,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(color: Color.fromARGB(139, 0, 0, 0)),
                      hintText: 'Recherhcer des plantes',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: Model.imageList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Card(
                          elevation: 20,
                          color: const Color.fromARGB(255, 215, 208, 208),
                          child: Container(
                            width: width / 1.2,
                            height: height / 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // height: 60,
                                  margin: const EdgeInsets.symmetric(vertical: 20),
                                  child: Image.file(
                                    Model.imageList[index],
                                    width: 100,
                                    // height: 100,
                                  ),
                                ),
                                Container(
                                    width: width / 2.5,
                                    height: height / 5,
                                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Picture $index",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        const Text(
                                          "cette tomate est malade",
                                        ),
                                        const Text("pp"),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 50,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
