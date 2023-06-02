import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_contact_diary_app/utils/my_page_route.dart';

import '../../controllers/theme_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Provider.of<ThemeController>(context, listen: false)
              //     .changeTheme();
              Navigator.of(context).pushNamed(MyPageRoute.hiddenContact);
            },
            icon: Provider.of<ThemeController>(context).isDark
                ? Icon(
                    Icons.light_mode,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.dark_mode,
                    color: Colors.white,
                  ),
          ),
        ],
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MyPageRoute.addContact);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
