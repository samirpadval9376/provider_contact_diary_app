import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:provider_contact_diary_app/controllers/list_controller.dart';
import 'package:provider_contact_diary_app/controllers/my_stepper_controller.dart';
import 'package:provider_contact_diary_app/utils/my_page_route.dart';
import 'package:url_launcher/url_launcher.dart';

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
            itemBuilder: (context, index) => Slidable(
              closeOnScroll: true,
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (val) async {
                      Uri uri = Uri(
                        scheme: 'tel',
                        path: provider.allHiddenContacts[index].contact,
                      );
                      await launchUrl(uri);
                    },
                    icon: Icons.phone,
                    backgroundColor: Colors.green,
                  ),
                  SlidableAction(
                    onPressed: (val) async {
                      // await Navigator.of(context).pushNamed(MyPageRoute.);
                    },
                    icon: Icons.edit,
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
              child: ListTile(
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                    MyPageRoute.detailContact,
                    arguments: index,
                  );
                },
                leading: CircleAvatar(
                  foregroundImage: FileImage(
                    File(provider.allHiddenContacts[index].imagePath!),
                  ),
                ),
                title: Text(
                    "${provider.allHiddenContacts[index].firstName} ${provider.allHiddenContacts[index].lastName}"),
                subtitle: Text("${provider.allHiddenContacts[index].contact}"),
                trailing: IconButton(
                  onPressed: () async {
                    Uri uri = Uri(
                      scheme: 'tel',
                      path: provider.allHiddenContacts[index].contact,
                    );
                    await launchUrl(uri);
                  },
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
