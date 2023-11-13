import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  final db = FirebaseFirestore.instance;
  final String? firstName;
  final String? lastName;
  final String? number;
  final String? email;
  final String? password;

  Firestore(
      {required this.firstName,
      required this.lastName,
      required this.number,
      required this.email,
      required this.password});

  factory Firestore.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Firestore(
        firstName: data?["firstName"],
        lastName: data?["lastName"],
        number: data?["number"],
        email: data?["email"],
        password: data?["password"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (number != null) "number": number,
      if (email != null) "email": email,
      if (password != null) "password": password,
    };
  }

  String? get userName {
    return "fdfd";
  }

  // Future<void> delete
}
