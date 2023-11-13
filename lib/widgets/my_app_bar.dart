import 'package:flutter/material.dart';
import 'package:plant_ai/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // automaticallyImplyLeading: false,
      title: const Text(
        "plantAI",
        style: TextStyle(fontSize: 20),
      ),
      
      // backgroundColor: Colors.transparent,
      actions: [
        Row(
          children: [
            Icon(
              Provider.of<AppStateNotifier>(context, listen: false).isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.sunny,
            ),
            const SizedBox(width: 8),
            Switch(
                value: Provider.of<AppStateNotifier>(context, listen: false)
                    .isDarkMode,
                activeColor: Colors.white,
                onChanged: (newValue) {
                  Provider.of<AppStateNotifier>(context, listen: false)
                      .updateTheme(newValue);
                  ;
                }),
          ],
        )
      ],
      // elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
