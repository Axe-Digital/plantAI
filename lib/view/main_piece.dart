import 'package:flutter/material.dart';
import 'package:plant_ai/auth/authentification.dart';
import 'package:plant_ai/services/firestore.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:plant_ai/model/model.dart';

class MainPiece extends StatefulWidget {
  const MainPiece({super.key});

  @override
  State<MainPiece> createState() => _MainPieceState();
}

class _MainPieceState extends State<MainPiece> {
  @override
  Widget build(BuildContext context) {
    final auth = Auth();
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.07,
          ),
          Row(
            children: [
              SizedBox(
                width: width * 0.1,
              ),
              RichText(
                text: TextSpan(
                  text: 'Hello, ',
                  style: TextStyle(
                    fontSize: theme.headlineSmall!.fontSize,
                    color: theme.headlineSmall!.color,
                    fontWeight: theme.headlineSmall!.fontWeight,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: auth.firstNameAuth() ?? Firestore.userName,
                      style: TextStyle(
                        fontSize: theme.headlineSmall!.fontSize,
                        color: theme.headlineSmall!.color,
                        fontWeight: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .fontWeight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                'assets/fougere.png',
                width: width / 7,
              )
            ],
          ),
          SizedBox(
            height: height * 0.09,
          ),
          Stack(children: [
            SizedBox(
              width: width,
              height: height / 3.5,
              child: Center(
                child: Container(
                    width: width * 0.8,
                    height: height / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),

                      color: Colors.green.withOpacity(0.55),
                      // border: Border.all(color: Colors.black)
                    ),
                    child: Container(
                      // color: Colors.amber,
                      margin: EdgeInsets.fromLTRB(width / 20, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "L'optiminisation de l'agricultur \nen avec l'IA et la vision la vision \npar Ordiateur",
                              style: TextStyle(
                                  fontSize: theme.bodyMedium!.fontSize,
                                  color: theme.bodyMedium!.color,
                                  fontWeight: theme.bodyMedium!.fontWeight)),
                        ],
                      ),
                    )),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Image.asset(
                'assets/plant.png',
                height: height / 5,
              ),
            )
          ]),
          SizedBox(
            height: height * 0.04,
          ),
          SizedBox(
            width: width * 0.8,
            height: height / 5,
            child: PieChart(
              emptyColor: Colors.black,
              dataMap: Model().dataMap,
              chartType: ChartType.ring,
              colorList: const [Colors.green],
              baseChartColor: Colors.green.withOpacity(0.15),
              chartRadius: 4000,
              totalValue: 20,
            ),
          ),
        ],
      ),
    );
  }
}
