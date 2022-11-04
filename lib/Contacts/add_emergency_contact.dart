import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rakshak_test/Contacts/contact.class.dart';
import 'package:rakshak_test/Contacts/select_contact.dart';
import 'package:rakshak_test/Message/customize_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


import 'contact.preferences.dart';

class AddPage extends StatefulWidget {
   const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late Contact contact;
  List<String> recipients = [];
  final player = AudioPlayer();
  bool playing = false;
  UserContact userContact = UserContact();
  List<UserContact> userContacts = [];
  FirebaseAuth _auth = FirebaseAuth.instance;
  String defaultMessage = "I might be in danger ";
  String? customizeMessage;

  @override
  void initState(){
    super.initState();

    userContacts = UserPreferences.getUsers();
    loadAllRecipients();
  }

  loadAllRecipients(){
    UserContact temp = UserContact();
    for(int i=0;i<userContacts.length;i++){
      temp = userContacts[i];
      recipients.add(temp.number);
    }
  }

  addRecipients(){
    setState(() {
      recipients.add(userContact.number);
    });
  }

  deleteRecipients(UserContact userContact){
    setState(() {
      recipients.remove(userContact.number);
    });
  }

  _sendSMS(String message, List<String> recipients) async{
    await Permission.sms.request();
    await sendSMS(message: message, recipients: recipients).catchError((onError){
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    int emergencyContactLength = userContacts.length;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: (){
              ModalRoute.of(context)?.canPop;
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("Emergency Contacts"),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children:[
              const Center(
                  child: Text(
                    "Messaging Alerts",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  )
              ),

              const SizedBox(height: 10),

              buildUsers(),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      fixedSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    String message;
                    if(customizeMessage==null){
                      message = "${defaultMessage}at this location \n(https://www.google.com/maps/search/?api=1&query=${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}).\nPowered by Rakshak";
                    }
                    else{
                      message = "${customizeMessage}at this location \n(https://www.google.com/maps/search/?api=1&query=${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}).\nPowered by Rakshak";
                    }
                    FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).collection('location log').add({
                      "location" :
                      'https://www.google.com/maps/search/?api=1&query=${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}',
                      "date/time" : Timestamp.now(),
                      "message" : customizeMessage ?? defaultMessage
                    });
                    _sendSMS(
                        message, recipients
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Message Successful'
                            ),
                            backgroundColor: Colors.green
                        )
                    );
                  },
                  child: const Text("Send Emergency Message")
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    fixedSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                  onPressed: () async {
                    setState(() {
                      playing = !playing;
                      playing? player.play(AssetSource('Audios/siren.mp3')): player.stop();
                    });
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    String message;
                    if(customizeMessage==null){
                      message = "${defaultMessage}at this location \n(https://www.google.com/maps/search/?api=1&query=${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}).\nPowered by Rakshak";
                    }
                    else{
                      message = "${customizeMessage}at this location \n(https://www.google.com/maps/search/?api=1&query=${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}).\nPowered by Rakshak";
                    }
                    FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).collection('location log').add({
                      "location" :
                      'https://www.google.com/maps/search/?api=1&query=${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}',
                      "date/time" : Timestamp.now(),
                      "message" : customizeMessage ?? defaultMessage
                    });
                    _sendSMS(
                        message, recipients
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Message Successful'
                            ),
                            backgroundColor: Colors.green
                        )
                    );
                  },
                  child: const Text("Send Emergency Message with Siren")
              ),

              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.deepPurple
                ),
                  onPressed: ()async{
                    customizeMessage = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CustomizeMessagePage())
                    );
                  },
                  child:const Text(
                      'Customize Message',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationThickness: 4
                      )
                  )
              )
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          if(emergencyContactLength<3){
            contact = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SelectContactPage())
            );
              final id = const Uuid().v4();
              userContact = userContact.copy(id: id,name: contact.displayName,number: contact.phones!.isNotEmpty ? '${contact.phones!.elementAt(0).value}' : '');
              await UserPreferences.addUser(userContact);
              await UserPreferences.setUser(userContact);
            setState(() {
              userContacts = UserPreferences.getUsers();
            });
            addRecipients();
          }

          else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
                content: Text("Maximum allowed : 3"),
              ),
            );
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildUsers()
  {
    if (userContacts.isEmpty) {
      return const Center(
        child: Text(
          'There are no users!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Expanded(
        child: ListView.separated(
          itemCount: userContacts.length,
          separatorBuilder: (context, index) => Container(height: 12),
          itemBuilder: (context, index) {
            userContact = userContacts[index];
            return ListTile(
              title: Text(userContact.name),
              subtitle: Text(userContact.number),
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(userContact.initials()),
              ),
              trailing: IconButton(
                  onPressed: ()async{
                    userContact = userContacts[index];
                    await UserPreferences.removeUser(userContact);
                    setState(() {
                      userContacts = UserPreferences.getUsers();
                    });
                    deleteRecipients(userContact);
                    },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )
              ),
            );
          },
        ),
      );
    }
  }
}

