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

  String allFirstName = "hidden_first_name";
  String allLastName = "hidden_last_name";
  String allNumbers = "hidden_contact";
  String allEmail = "hidden_email";
  String allImage = "hidden_image";

  List<String> getAllFirstNames = [];
  List<String> getAllLastNames = [];
  List<String> getAllNumbers = [];
  List<String> getAllEmails = [];
  List<String> getAllImages = [];

  List<Contacts> allContacts = [];
  List<Contacts> allHiddenContacts = [];

  List<Contacts> get getAllContacts {
    getAllFirstNames = prefs.getStringList(allFirstName) ?? [];
    getAllLastNames = prefs.getStringList(allLastName) ?? [];
    getAllNumbers = prefs.getStringList(allNumbers) ?? [];
    getAllEmails = prefs.getStringList(allEmail) ?? [];
    getAllImages = prefs.getStringList(allImage) ?? [];

    allContacts = List.generate(
      allNumbers.length,
      (index) => Contacts(
        firstName: getAllFirstNames[index],
        lastName: getAllLastNames[index],
        contact: getAllNumbers[index],
        email: getAllEmails[index],
        imagePath: getAllImages[index],
      ),
    );
    return allContacts;
  }

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
        contact: allHiddenNumbers[index],
        email: allHiddenEmails[index],
        imagePath: allHiddenImages[index],
      ),
    );
    return allHiddenContacts;
  }

  void addContact({
    required String firstName,
    required String lastName,
    required String contact,
    required String email,
    required String imagePath,
  }) {
    getAllFirstNames = prefs.getStringList(allFirstName) ?? [];
    getAllLastNames = prefs.getStringList(allLastName) ?? [];
    getAllNumbers = prefs.getStringList(allNumbers) ?? [];
    getAllEmails = prefs.getStringList(allEmail) ?? [];
    getAllImages = prefs.getStringList(allImage) ?? [];

    getAllFirstNames.add(firstName);
    getAllLastNames.add(lastName);
    getAllNumbers.add(contact);
    getAllEmails.add(email);
    getAllImages.add(imagePath);

    prefs.setStringList(allFirstName, getAllFirstNames);
    prefs.setStringList(allLastName, getAllLastNames);
    prefs.setStringList(allNumbers, getAllNumbers);
    prefs.setStringList(allEmail, getAllEmails);
    prefs.setStringList(allImage, getAllImages);
    notifyListeners();
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
    notifyListeners();
  }
}
