import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_contact_diary_app/controllers/list_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/my_page_route.dart';

class DetailsContactPage extends StatelessWidget {
  const DetailsContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = ModalRoute.of(context)!.settings.arguments as int;
    Size s = MediaQuery.of(context).size;

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
          "Contacts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<ListController>(
          builder: (context, provider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: s.height * 0.08,
              ),
              Container(
                height: s.height * 0.2,
                width: s.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // CircleAvatar(
                    //   radius: 70,
                    //   foregroundImage: FileImage(
                    //     File(provider.allHiddenContacts[i].imagePath!),
                    //   ),
                    // ),
                    SizedBox(
                      width: s.width * 0.03,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          // Globals.allContacts.removeAt(i);
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          // Navigator.of(context)
                          //     .pushNamed(MyPageRoute.editContact, arguments: i);
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: s.height * 0.03,
              ),
              Text(
                "${provider.getAllContacts[i].firstName} ${provider.getAllContacts[i].lastName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: s.height * 0.03,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "+91 ${provider.getAllContacts[i].contact}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: s.height * 0.02,
              ),
              const Divider(),
              SizedBox(
                height: s.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      Uri uri = Uri(
                        scheme: 'tel',
                        path: provider.getAllContacts[i].contact,
                      );
                      await launchUrl(uri);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      Uri uri = Uri(
                        scheme: 'sms',
                        path: provider.getAllContacts[i].contact,
                      );
                      await launchUrl(uri);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.amber,
                    child: const Icon(
                      Icons.sms,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      Uri uri = Uri(
                        scheme: 'mailto',
                        path: provider.getAllContacts[i].email,
                      );
                      await launchUrl(uri);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Share.share(
                          "Name: ${provider.getAllContacts[i].firstName}\nContact: ${provider.getAllContacts[i].contact}");
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.orange,
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: s.height * 0.02,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
