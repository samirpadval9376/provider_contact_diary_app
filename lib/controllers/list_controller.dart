import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/contacts_modals.dart';

class ListController extends ChangeNotifier {
  SharedPreferences prefs;

  ListController({required this.prefs});

  String hiddenFirstName = "hidden_first_name";
  String hiddenLastName = "hidden_last_name";
  String hiddenNumbers = "hidden_contact";
  String hiddenEmail = "hidden_email";
  String hiddenImage = "hidden_image";

  List<String> allHiddenFirstNames = [];
  List<String> allHiddenLastNames = [];
  List<String> allHiddenNumbers = [];
  List<String> allHiddenEmails = [];
  List<String> allHiddenImages = [];

  List<Contacts> allContacts = [];
  List<Contacts> allHiddenContacts = [];

  List<Contacts> get getAllHiddenContacts {
    allHiddenFirstNames = prefs.getStringList(hiddenFirstName) ?? [];
    allHiddenLastNames = prefs.getStringList(hiddenLastName) ?? [];
    allHiddenNumbers = prefs.getStringList(hiddenNumbers) ?? [];
    allHiddenEmails = prefs.getStringList(hiddenEmail) ?? [];
    allHiddenImages = prefs.getStringList(hiddenImage) ?? [];

    allHiddenContacts = List.generate(
      allHiddenNumbers.length,
      (index) => Contacts(
        firstName: allHiddenFirstNames[index],
        lastName: allHiddenLastNames[index],
        contact: int.parse(allHiddenNumbers[index]),
        email: allHiddenEmails[index],
        imagePath: allHiddenImages[index],
      ),
    );
    return allHiddenContacts;
  }

  void addHiddenContact({
    required String firstName,
    required String lastName,
    required String contact,
    required String email,
    required String imagePath,
  }) {
    allHiddenFirstNames = prefs.getStringList(hiddenFirstName) ?? [];
    allHiddenLastNames = prefs.getStringList(hiddenLastName) ?? [];
    allHiddenNumbers = prefs.getStringList(hiddenNumbers) ?? [];
    allHiddenEmails = prefs.getStringList(hiddenEmail) ?? [];
    allHiddenImages = prefs.getStringList(hiddenImage) ?? [];

    allHiddenFirstNames.add(firstName);
    allHiddenLastNames.add(lastName);
    allHiddenNumbers.add(contact);
    allHiddenEmails.add(email);
    allHiddenImages.add(imagePath);

    prefs.setStringList(hiddenFirstName, allHiddenFirstNames);
    prefs.setStringList(hiddenLastName, allHiddenLastNames);
    prefs.setStringList(hiddenNumbers, allHiddenNumbers);
    prefs.setStringList(hiddenEmail, allHiddenEmails);
    prefs.setStringList(hiddenImage, allHiddenImages);
  }
}
