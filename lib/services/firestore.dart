import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_ai/auth/authentification.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Firestore {
  final db = FirebaseFirestore.instance;
  final auth = Auth();
  static String? userName;
  // String get name
  static set saveUserName(String? _) {
    userName = _;
  }

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

  Future<void> uploadData() async {
    final userId = auth.userId;
    print("userId => $userId");
    print(firstName);
    print(lastName);
    print(password);
    print(email);
    print(number);
    final user = Firestore(
        firstName: firstName,
        lastName: lastName,
        number: number,
        email: email,
        password: password);
    final docRef = db
        .collection("users")
        .withConverter(
            fromFirestore: Firestore.fromFirestore,
            toFirestore: (Firestore user, options) => user.toFirestore())
        .doc(auth.userId);
    await docRef.set(user);
  }

  static Future<String?> getFirstName() async {
    final db = FirebaseFirestore.instance;
    final auth = Auth();
    try {
      final ref = db.collection("users").doc(auth.userId).withConverter(
          fromFirestore: Firestore.fromFirestore,
          toFirestore: (Firestore user, options) => user.toFirestore());
      final docSnap = await ref.get();
      final user = docSnap.data();
      return user!.firstName!;
    } on FirebaseFirestore catch (e) {
      print("Error userName : $e ");
      return null;
    }
  }

  // Future<void> delete
}
