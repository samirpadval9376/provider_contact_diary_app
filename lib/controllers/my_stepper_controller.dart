import 'dart:io';

import 'package:flutter/material.dart';

class StepperController extends ChangeNotifier {
  int currentStep = 0;
  String? firstName;
  String? lastName;
  String? email;
  int? contact;

  File? imagePath;

  bool isHidden = false;

  void hide() {
    isHidden = !isHidden;
    notifyListeners();
  }

  void stepIncrease() {
    if (currentStep < 5) {
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
    imagePath = img;
    notifyListeners();
  }
}
