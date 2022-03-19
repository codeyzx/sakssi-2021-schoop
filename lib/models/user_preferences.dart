import 'dart:convert';
import 'picture_model.dart';
import 'package:schoop/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
  static const _keyUser = 'picture';
  static AuthService myUser = AuthService();
  /*User(
      imagePath: "https://cdn-2.tstatic.net/tribunnews/foto/bank/images/sinopsis-film-john-wick-tayang-spesial-di-bioskop-trans-tv-selasa-17-desember-2019-pukul-1900-wib.jpg",
      nis: "",
      name: "Admin",
      email: "admin@gmail.com",
  );*/
  static Picture users = Picture(
      imagePath:
          'https://cdn.vox-cdn.com/thumbor/r2JatX_TXrN3qywO7qOiFiAyGPo=/0x0:2370x1574/1400x933/filters:focal(996x598:1374x976):no_upscale()/cdn.vox-cdn.com/uploads/chorus_image/image/68870438/Screen_Shot_2020_07_21_at_9.38.25_AM.0.png');

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUser(Picture picture) async {
    final json = jsonEncode(picture.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static Picture? getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? users : Picture.fromJson(jsonDecode(json));
  }
}
