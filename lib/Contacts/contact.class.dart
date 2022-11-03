import 'package:contacts_service/contacts_service.dart';

class UserContact{
  final String id;
  final String name;

  //List<Contact> contacts = [];

   UserContact({
    this.id = '',
    this.name = '',
  });

  UserContact copy({
    String? id,
    String? name
  }) =>
      UserContact(
          id: id ?? this.id,
          name: name ?? this.name
      );

  static UserContact formJSON(Map<String,dynamic> json) => UserContact(
      id: json['id'],
      name: json['name']
  );

  Map<String,dynamic> toJSON()=>{
    'id' : id,
    'name' : name
  };
}