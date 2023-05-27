import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_contact_diary_app/controllers/my_stepper_controller.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
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
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Consumer<StepperController>(
          builder: (context, provider, widget) => Stepper(
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
                                icon: Icon(
                                  Icons.camera_alt,
                                ),
                                label: const Text("Camera"),
                              ),
                            ],
                          ),
                        );
                      },
                      mini: true,
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text("First Name"),
                content: Container(),
              ),
              Step(
                title: const Text("Last Name"),
                content: Container(),
              ),
              Step(
                title: const Text("Contact"),
                content: Container(),
              ),
              Step(
                title: const Text("Email"),
                content: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
