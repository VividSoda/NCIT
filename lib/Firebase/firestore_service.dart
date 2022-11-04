import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future insertNote(String _name, String _email, String _password, String _confirmPass) async{
    try{
      await firestore.collection('users').add({
        "name" : _name,
        "email" : _email,
        "password" : _password,
        "confirm password" : _confirmPass,
      }
      );
    }

    catch(e){
      print(e);
    }
}
}