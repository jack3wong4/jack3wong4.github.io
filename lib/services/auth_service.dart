import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Future getOrCreateUser() async {
    if (currentUser == null) {
      await _firebaseAuth.signInAnonymously();
      DocumentReference document = FirebaseFirestore.instance
          .collection('users_c')
          .doc(currentUser?.uid);
      if (currentUser != null) {
        document.set({'detail_1': 'Waiting', 'detail_2': 10});
      }
    }
    return currentUser;
  }
}
