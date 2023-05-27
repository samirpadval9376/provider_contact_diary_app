import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StepperController extends ChangeNotifier {
  int currentStep = 0;
  String? firstName;
  String? lastName;
  String? email;
  int? contact;

  File? image;

  void stepIncrease() {
    if (currentStep < 4) {
      currentStep++;
    }
    notifyListeners();
  }

  void stepDecrease() {
    if (currentStep > 0) {
      currentStep--;
    }
    notifyListeners();
  }

  void addImage({required File img}) {
    image = img;
    notifyListeners();
  }
}