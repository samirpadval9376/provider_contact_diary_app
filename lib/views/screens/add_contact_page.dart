import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider_contact_diary_app/controllers/list_controller.dart';
import 'package:provider_contact_diary_app/controllers/my_stepper_controller.dart';
import 'package:provider_contact_diary_app/modals/contacts_modals.dart';
import 'package:provider_contact_diary_app/views/componenets/my_snackbar.dart';

import '../../controllers/my_stepper_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../modals/globals_modals.dart';

class AddContactPage extends StatelessWidget {
  AddContactPage({Key? key}) : super(key: key);

  GlobalKey<FormState> formkey = GlobalKey();

  String? firstName;
  String? lastName;
  String? contact;
  String? email;
  String? imagePath;

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
          "Add Contact Page",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeController>(context, listen: false)
                  .changeTheme();
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
          IconButton(
            onPressed: () async {
              Directory? dir = await getExternalStorageDirectory();

              File newImage =
                  await Provider.of<StepperController>(context, listen: false)
                      .imagePath!
                      .copy("${dir!.path}/$firstName.jpg");

              if (formkey.currentState!.validate()) {
                formkey.currentState!.save();
                if (Provider.of<StepperController>(context, listen: false)
                        .isHidden ==
                    true) {
                  Provider.of<ListController>(context, listen: false)
                      .addHiddenContact(
                    firstName: firstName!,
                    lastName: lastName!,
                    contact: contact!,
                    email: email!,
                    imagePath: newImage.path,
                  );
                }

                Navigator.of(context).pop();
              } else if (formkey.currentState!.validate()) {
                formkey.currentState!.save();
                if (Provider.of<StepperController>(context, listen: false)
                        .isHidden ==
                    false) {
                  Provider.of<ListController>(context, listen: false)
                      .addContact(
                    firstName: firstName!,
                    lastName: lastName!,
                    contact: contact!,
                    email: email!,
                    imagePath: newImage.path,
                  );
                }
                Navigator.of(context).pop();
              } else {
                print("==================");
                print(
                    "${Provider.of<ListController>(context, listen: false).getAllContacts.length}");
                print("===================");
              }
            },
            icon: const Icon(
              Icons.done,
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
        child: Consumer<StepperController>(
          builder: (context, provider, widget) => Form(
            key: formkey,
            child: Stepper(
              currentStep: provider.currentStep,
              onStepContinue: () {
                provider.stepIncrease();
              },
              onStepCancel: () {
                provider.stepDecrease();
              },
              steps: <Step>[
                Step(
                  title: const Text("Add Image"),
                  content: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        foregroundImage: provider.imagePath != null
                            ? FileImage(provider.imagePath!)
                            : null,
                        child: const Text("Add Image"),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Select Method"),
                              actions: [
                                TextButton.icon(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    ImagePicker picker = ImagePicker();

                                    XFile? img = await picker.pickImage(
                                      source: ImageSource.camera,
                                    );

                                    if (img != null) {
                                      provider.addImage(
                                        img: File(img.path),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                  ),
                                  label: const Text("Camera"),
                                ),
                                TextButton.icon(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    ImagePicker picker = ImagePicker();

                                    XFile? img = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    if (img != null) {
                                      provider.addImage(
                                        img: File(img.path),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                  ),
                                  label: const Text("Gallery"),
                                ),
                              ],
                            ),
                          );
                        },
                        mini: true,
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text("First Name"),
                  content: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Enter the First Name",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter the First Name";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      firstName = val;
                    },
                  ),
                ),
                Step(
                  title: const Text("Last Name"),
                  content: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Enter the First Name",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter the First Name";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      lastName = val;
                    },
                  ),
                ),
                Step(
                  title: const Text("Contact"),
                  content: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the First Name",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter the First Name";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      contact = val;
                    },
                  ),
                ),
                Step(
                  title: const Text("Email"),
                  content: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the First Name",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter the First Name";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      email = val;
                    },
                  ),
                ),
                Step(
                  title: const Text("Hide"),
                  content: CheckboxListTile(
                    title: const Text("Hide"),
                    value: provider.isHidden,
                    onChanged: (val) {
                      provider.hide();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
