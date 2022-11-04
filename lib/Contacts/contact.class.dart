class UserContact{
  final String id;
  final String name;
  final String number;

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
    return name.isNotEmpty
        ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
        : '';
  }
}