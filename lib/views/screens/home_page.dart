import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:provider_contact_diary_app/utils/my_page_route.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/list_controller.dart';
import '../../controllers/theme_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: () async {
            LocalAuthentication auth = LocalAuthentication();

            bool done =
                await auth.authenticate(localizedReason: "Hidden Contacts");

            if (done) {
              Navigator.of(context).pushNamed(MyPageRoute.hiddenContact);
            }
          },
          child: const Text(
            "Home Page",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeController>(context, listen: false)
                  .changeTheme();
              // Navigator.of(context).pushNamed(MyPageRoute.hiddenContact);
            },
            icon: Provider.of<ThemeController>(context).isDark
                ? const Icon(
                    Icons.light_mode,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.dark_mode,
                    color: Colors.white,
                  ),
          ),
        ],
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Consumer<ListController>(
          builder: (context, provider, child) => ListView.builder(
            itemCount: provider.getAllContacts.length,
            itemBuilder: (context, index) => Slidable(
              closeOnScroll: true,
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (val) async {
                      Uri uri = Uri(
                        scheme: 'tel',
                        path: provider.allContacts[index].contact,
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
                    File(provider.getAllContacts[index].imagePath!),
                  ),
                ),
                title: Text(
                    "${provider.getAllContacts[index].firstName} ${provider.getAllContacts[index].lastName}"),
                subtitle: Text("${provider.getAllContacts[index].contact}"),
                trailing: IconButton(
                  onPressed: () async {
                    Uri uri = Uri(
                      scheme: 'tel',
                      path: provider.getAllContacts[index].contact,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MyPageRoute.addContact);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
