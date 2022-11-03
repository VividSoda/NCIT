import 'dart:convert';
import 'package:rakshak_test/Contacts/contact.class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static late SharedPreferences _preferences;

  static Future init() async{
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUser(UserContact userContact) async{
    final json = jsonEncode(userContact.toJSON());
    final idUser = userContact.id;

    await _preferences.setString(idUser, json);
  }

  static UserContact getUser(String idUser){
    final json = _preferences.getString(idUser);
    return UserContact.formJSON(jsonDecode(json!));
  }
}