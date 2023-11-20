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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width * 0.9,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(15),
              //   // color: Colors.white,
              // ),
              child: TextField(
                controller: textEditingTextField,
                // style: const TextStyle(color: Colors.white),
                maxLines: null,
                decoration: InputDecoration(
                  // fillColor: theme.bodyMedium!.color,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                      color: Colors.green.withOpacity(0.5),
                    ),
                  ),

                  prefixIcon: const Icon(Icons.search),
                  hintStyle: theme.bodyMedium!,
                  hintText: 'Recherhcer des plantes',
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: Model.imageList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: height / 20,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 20,
                        child: Container(
                          width: width / 1.2,
                          height: height / 4,
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.55),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: height / 5,
                                width: width / 3,

                                // color: Colors.red,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                // child: Text("data"),
                                child: Image.file(
                                  Model.imageList[index],
                                  width: 100,
                                  height: 1000,
                                ),
                              ),
                              Container(
                                  width: width / 4,
                                  height: height / 5,
                                  // color: Colors.red,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Picture ${index + 1}",
                                        style: TextStyle(
                                            fontSize:
                                                theme.bodyMedium!.fontSize),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Text(
                                        "cette tomate est malade",
                                      ),
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
    });
  }
}
