import 'dart:convert';
import 'package:rakshak_test/Contacts/contact.class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static late SharedPreferences _preferences;
  static const _keyUsers = 'users';

  static Future init() async{
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUser(UserContact userContact) async{
    final json = jsonEncode(userContact.toJSON());
    final idUser = userContact.id;

    await _preferences.setString(idUser, json);
  }

  static  UserContact getUser(String idUser){
    final json = _preferences.getString(idUser);
    return UserContact.formJSON(jsonDecode(json!));
  }

  static Future addUser(UserContact userContact) async{
    final idUsers = _preferences.getStringList(_keyUsers)??<String>[];
    final newIdUsers = List.of(idUsers)..add(userContact.id);
    await _preferences.setStringList(_keyUsers, newIdUsers);
  }

  static Future removeUser(UserContact userContact) async{
    final idUsers = _preferences.getStringList(_keyUsers)??<String>[];
    final newIdUsers = List.of(idUsers)..remove(userContact.id);
    await _preferences.setStringList(_keyUsers, newIdUsers);
  }

  static List<UserContact> getUsers(){
    final idUsers = _preferences.getStringList(_keyUsers);
    if(idUsers==null){
      return <UserContact>[];
    }
    else{
      return idUsers.map<UserContact>(getUser).toList();
    }
  }
}