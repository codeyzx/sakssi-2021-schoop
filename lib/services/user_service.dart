import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoop/models/user_model.dart';

class UserService {
  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'nis': user.nis,
        'picture': "",
        'pengeluaran': 0,
        'pendapatan': 0,
        'seragam': 0,
        'spp': 0,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
          id: id,
          email: snapshot['email'],
          nis: snapshot['nis'],
          name: snapshot['name'],
          denda: 0,
          picture: "");
    } catch (e) {
      throw e;
    }
  }
}
