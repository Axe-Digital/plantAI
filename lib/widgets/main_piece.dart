import 'package:flutter/material.dart';
import 'package:plant_ai/auth/authentification.dart';
import 'package:plant_ai/services/firestore.dart';
import 'package:plant_ai/theme/theme_manager.dart';
import 'package:provider/provider.dart';

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
    final height = MediaQuery.of(context).size.height;
    final isDark =
        Provider.of<AppStateNotifier>(context, listen: false).isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: TextField(
        //     controller: null,
        //     decoration: const InputDecoration(
        //       hintText: 'Rechercher...',
        //       suffixIcon: Icon(Icons.search),
        //     ),
        //     onSubmitted: (value) {
        //       // Gérer la soumission de la recherche ici
        //     },
        //   ),
        // ),
        Container(
            margin: EdgeInsets.only(left: width * 0.08),
            child: Row(
              children: [
                auth.firstNameAuth() != null
                    ? RichText(
                        text: TextSpan(
                          text: 'Hello, ',
                          style: const TextStyle(
                              fontSize: 35, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${auth.firstNameAuth()}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          text: 'Hello, ',
                          style: const TextStyle(
                              fontSize: 35, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${Firestore.userName}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/fougere.png',
                  width: 70,
                  height: 70,
                )
              ],
            )),
        const SizedBox(
          height: 5,
        ),
        Stack(children: [
          Container(
              margin: const EdgeInsets.fromLTRB(60, 30, 0, 20),
              constraints: BoxConstraints(maxWidth: width * 0.9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Colors.lightGreen,
                    Colors.lightGreen,
                    Colors.white,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                color: Colors.white,
                // border: Border.all(color: Colors.black)
              ),
              width: width * 0.8,
              padding: const EdgeInsets.fromLTRB(20, 50, 0, 70),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("L'optiminisation ",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Text(" de l'agriculture avec ",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Text("avec l'IA et la vision ",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  Text("la vision par Ordiateur",
                      style: TextStyle(fontSize: 20, color: Colors.black))
                ],
              )),
          Positioned(
            right: 5,
            top: 0,
            child: Image.asset(
              'assets/flowers.png',
              height: 200,
              // width: 100,
            ),
          )
        ]),
        Container(
          height: height * 0.3,
          width: width * 0.8,
          margin: const EdgeInsets.fromLTRB(60, 0, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Colors.lightGreen,
                Colors.lightGreen,
                Colors.white,
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
        ),
        // const Camera(),
      ],
    );
  }
}
