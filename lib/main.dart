import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_contact_diary_app/controllers/my_stepper_controller.dart';
import 'package:provider_contact_diary_app/utils/my_page_route.dart';
import 'package:provider_contact_diary_app/views/screens/add_contact_page.dart';
import 'package:provider_contact_diary_app/views/screens/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(
          create: (context) => StepperController(),
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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      routes: {
        MyPageRoute.home: (context) => HomePage(),
        MyPageRoute.addContact: (context) => AddContactPage(),
      },
    );
  }
}
