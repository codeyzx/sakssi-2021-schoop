import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  // final String imagePath;
  final String id;
  final String email;
  final String name;
  final String nis;
  final int denda;
  final String picture;

  const UserModel(
      {
      // required this.imagePath,
      required this.id,
      required this.email,
      required this.denda,
      required this.nis,
      required this.name,
      required this.picture});

  factory UserModel.fromMap(data) => UserModel(
      id: data['id'],
      email: data['email'],
      denda: data['denda'],
      nis: data['nis'],
      name: data['name'],
      picture: data['picture']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'nis': nis,
      'denda': denda,
      'picture': picture
    };
  }

  UserModel copyWith(
          {String? id,
          String? email,
          String? name,
          String? nis,
          String? picture,
          int? denda}) =>
      UserModel(
          id: id ?? this.id,
          email: email ?? this.email,
          denda: denda ?? this.denda,
          nis: nis ?? this.nis,
          name: name ?? this.name,
          picture: picture ?? this.picture);

  @override
  List<Object?> get props => [id, email, nis, denda, name, picture];
}
