import 'dart:io';

class Contacts {
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? contact;

  late String? imagePath;

  Contacts({
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.email,
    required this.imagePath,
  });
}
