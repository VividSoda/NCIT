import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Register User

  Future<User?> register (String _email, String _password, BuildContext context) async {
    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: _email, password: _password
      );
      return userCredential.user;
    }

    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()), backgroundColor: Colors.red));
    }

    catch(e){
      print(e);
    }
    return null;
  }

  //Login User
  Future<User?> login (String _email, String _password, BuildContext context) async{
    try{
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );

      return userCredential.user;
    }

    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()), backgroundColor: Colors.red));
    }

    catch(e){
      print(e);
    }
    return null;
  }

  //Google Sign In
Future<User?> signInWithGoogle() async{
   try{
     //Trigger authentication dialog
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

     if(googleUser != null){
       //obtain auth details from the request
       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

       //create new credential
       final credential = GoogleAuthProvider.credential(
           accessToken: googleAuth.accessToken,
           idToken: googleAuth.idToken
       );

       //Once signed in return the user data form firebase
       UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
       return userCredential.user;
     }
   }

   catch(e){
     print(e);
   }
}

//Sign out
Future signOut() async{
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
}
}