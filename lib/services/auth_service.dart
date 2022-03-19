import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoop/models/user_model.dart';
import 'package:schoop/services/user_service.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel user =
          await UserService().getUserById(userCredential.user!.uid);
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> signUp(
      {required String email,
      required String password,
      required String name,
      required String nis}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
          id: userCredential.user!.uid,
          email: email,
          nis: nis,
          name: name,
          denda: 0,
          picture: "");
      await UserService().setUser(user);
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProfile(String name, String email, String nis) async {
    final User user = await _auth.currentUser!;
    final userId = user.uid;
    try {
      await UserService().getUserById(userId);
      CollectionReference docRef = firestore.collection('users');
      await docRef.doc(userId).set({
        'email': email,
        'name': name,
        'nis': nis,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }
}
