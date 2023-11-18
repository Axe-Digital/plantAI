import 'package:flutter/material.dart';
import 'package:plant_ai/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDark =
        Provider.of<AppStateNotifier>(context, listen: false).isDarkMode;
    return AppBar(
      // automaticallyImplyLeading: false,
      // title: const Text(
      //   "plantAI",
      //   style: TextStyle(fontSize: 20),
      // ),
      title: Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Icon(
              Provider.of<AppStateNotifier>(context, listen: false).isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.sunny,
            ),
            Switch(
                value: Provider.of<AppStateNotifier>(context, listen: false)
                    .isDarkMode,
                activeColor: Colors.white,
                onChanged: (newValue) {
                  Provider.of<AppStateNotifier>(context, listen: false)
                      .updateTheme(newValue);
                }),
          ],
        ),
      ),
      elevation: 0,

      // bottom: const PreferredSize(
      //   preferredSize: Size.fromHeight(0),
      //   child: SizedBox.shrink(),
      // ),

      // backgroundColor: Colors.transparent,
      actions: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              // const SizedBox(width: 20),
              // InkWell(),

              Icon(Icons.search),
              SizedBox(width: width * 0.05),

              Center(
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person))),
            ],
          ),
        )
      ],
      // elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
