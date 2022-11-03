import 'package:contacts_service/contacts_service.dart';

class UserContact{
  final String id;
  final String name;
  final String number;

  //List<Contact> contacts = [];

   UserContact({
    this.id = '',
    this.name = '',
     this.number = ''
  });

  UserContact copy({
    String? id,
    String? name,
    String? number
  }) =>
      UserContact(
          id: id ?? this.id,
          name: name ?? this.name,
          number: number??this.number
      );

  static UserContact formJSON(Map<String,dynamic> json) => UserContact(
      id: json['id'],
      name: json['name'],
    number: json['number']
  );

  Map<String,dynamic> toJSON()=>{
    'id' : id,
    'name' : name,
    'number' : number
  };

  String initials() {
    //List<String> nameParts = name.split(" ");
    return name.isNotEmpty
        ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
        : '';
    //String initials = nameParts[0]![0].toUpperCase() + nameParts[1]![0].toUpperCase();
     //String initials = (nameParts[0].isNotEmpty==true? nameParts[0]![0].toUpperCase():'') + (nameParts[1].isNotEmpty==true? nameParts[1]![0].toUpperCase():'');
    //return initials;
  }
}