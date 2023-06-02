import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_contact_diary_app/controllers/list_controller.dart';
import 'package:provider_contact_diary_app/controllers/my_stepper_controller.dart';
import 'package:provider_contact_diary_app/controllers/theme_controller.dart';
import 'package:provider_contact_diary_app/utils/my_page_route.dart';
import 'package:provider_contact_diary_app/views/screens/add_contact_page.dart';
import 'package:provider_contact_diary_app/views/screens/hidden_contact_page.dart';
import 'package:provider_contact_diary_app/views/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StepperController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeController(prefs: prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => ListController(prefs: prefs),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ThemeController>(context).getTheme
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      routes: {
        MyPageRoute.home: (context) => HomePage(),
        MyPageRoute.addContact: (context) => AddContactPage(),
        MyPageRoute.hiddenContact: (context) => HiddenContactPage(),
      },
    );
  }
}
