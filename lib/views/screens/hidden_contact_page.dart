import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_contact_diary_app/controllers/list_controller.dart';

class HiddenContactPage extends StatelessWidget {
  const HiddenContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Hidden Contact Page",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Consumer<ListController>(
          builder: (context, provider, child) => ListView.builder(
            itemCount: provider.getAllHiddenContacts.length,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                foregroundImage: FileImage(
                  File(provider.allHiddenContacts[index].imagePath!),
                ),
              ),
              title: Text(
                  "${provider.allHiddenContacts[index].firstName!} ${provider.allHiddenContacts[index].lastName!}"),
            ),
          ),
        ),
      ),
    );
  }
}
