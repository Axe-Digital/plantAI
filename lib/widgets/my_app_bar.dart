import 'package:flutter/material.dart';
import 'package:plant_ai/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double prefferedHeight;
  const MyAppBar({super.key, required this.prefferedHeight});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        // margin: const EdgeInsets.only(top: 20),
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
      actions: [
        Container(
          // margin: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              const Icon(Icons.search),
              SizedBox(width: width * 0.05),
              Center(
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person))),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(prefferedHeight);
}
