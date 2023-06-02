import 'dart:io';

class Contacts {
  String? firstName;
  String? lastName;
  String? email;
  int? contact;

  String? imagePath;

  Contacts({
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.email,
    required this.imagePath,
  });
}
