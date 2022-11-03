import 'package:audioplayers/audioplayers.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:rakshak_test/Contacts/contact.class.dart';
import 'package:rakshak_test/Contacts/select_contact.dart';
import 'package:uuid/uuid.dart';


import 'contact.preferences.dart';

class AddPage extends StatefulWidget {
  String idUser='c9b70a0c-070e-493a-a930-a64ea70405f4';
  AddPage(this.idUser);
  // AddPage({Key? key,required this.idUser}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  List<Contact> emergencyContact = [];
  late Contact contact;
  List<String> recipients = [];
  final player = AudioPlayer();
  bool playing = false;
 late UserContact userContact;
 // print('####################Id:${id}###############');

  @override
  void initState(){
    super.initState();
    final id = const Uuid().v4();
    print('####################Id:${id}###############');
    // if (widget.idUser==null||widget.idUser=='') {
    //   print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    //   print(widget.idUser);
    //   userContact = UserContact(id: id);
    //   print('+++####################Id:${userContact.id}###############++++');
    // }
    // else {
      userContact = UserPreferences.getUser(widget.idUser);
      print('+++++++++++++++++++####${userContact.name}########+++++++');
   // }
  }

  addItemToList(){
    setState(() {
      emergencyContact.add(contact);
    });
  }

  deleteListItem(Contact _contact){
    setState(() {
      emergencyContact.remove(_contact);
    });
  }

  addRecipients(){
    setState(() {
      recipients.add(contact.phones!.elementAt(0).value.toString());
    });
  }

  deleteRecipients(Contact contact){
    setState(() {
      recipients.remove(contact.phones!.elementAt(0).value.toString());
    });
  }

  _sendSMS(String message, List<String> recipients) async{
    await sendSMS(message: message, recipients: recipients).catchError((onError){
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    int emergencyContactLength = emergencyContact.length;
    bool emergencyListExist = (emergencyContact.isNotEmpty);

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
              
              Text('+++++++++++++++++++++++++++++++++++++${userContact.name}+++++++++++++++++++++++++++++')

              // userContact!=null? ListTile(
              //   title: Text('${userContact!.displayName}'),
              //               subtitle: Text(userContact!.phones!.isNotEmpty ? '${userContact!.phones!.elementAt(0).value}' : ''),
              //               leading: (userContact!.avatar != null && userContact!.avatar!.isNotEmpty) ?
              //               CircleAvatar(
              //                 backgroundImage: MemoryImage(userContact!.avatar!),
              //               ) :
              //               CircleAvatar(
              //                 backgroundColor: Colors.deepPurple,
              //                 child: Text(userContact!.initials()),
              //               ),
              // ):Text("null"),

              // (emergencyListExist)? Expanded(
              //     child: ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: emergencyContact.length,
              //         itemBuilder: (context,index){
              //           Contact contact = emergencyContact[index];
              //           return ListTile(
              //             title: Text('${contact.displayName}'),
              //             subtitle: Text(contact.phones!.isNotEmpty ? '${contact.phones!.elementAt(0).value}' : ''),
              //             leading: (contact.avatar != null && contact.avatar!.isNotEmpty) ?
              //             CircleAvatar(
              //               backgroundImage: MemoryImage(contact.avatar!),
              //             ) :
              //             CircleAvatar(
              //               backgroundColor: Colors.deepPurple,
              //               child: Text(contact.initials()),
              //             ),
              //             trailing: IconButton(
              //                 onPressed: (){
              //                   contact = emergencyContact[index];
              //                   deleteListItem(contact);
              //                   deleteRecipients(contact);
              //                 },
              //                 icon: const Icon(
              //                   Icons.delete,
              //                   color: Colors.red,
              //                 )
              //             ),
              //           );
              //         }
              //     )
              // ):
              // Container(
              //     padding: const EdgeInsets.all(20),
              //     child: const Text("No items added")
              // ),
              //
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         primary: Colors.deepPurple
              //     ),
              //     onPressed: () async {
              //       setState(() {
              //         playing = !playing;
              //         playing? player.play(AssetSource('Audios/siren.mp3')): player.stop();
              //       });
              //       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              //       String message;
              //       message = "I might be in danger at this location \n(https://www.google.com/maps/search/?api=1&query=${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}).\nPowered by Rakshak";
              //       // message = "I might be in danger at this location \n(${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}).\nPlease copy this co-ordinates in Google Maps.\nThis message has been sent by Rakshak";
              //       // print("I might be in danger at this location (${sharedPreferences.getDouble("latitude")},${sharedPreferences.getDouble("longitude")}). Please copy this co-ordinates in Google Maps.\n This message has been sent by Rakshak");
              //       // print("#####################"+sharedPreferences.getDouble("latitude").toString()+"*************************");
              //       // print("#####################"+sharedPreferences.getDouble("longitude").toString()+"*************************");
              //       _sendSMS(
              //           message, recipients);
              //     },
              //     child: const Text("Send message")
              // )
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
            setState(() {
              userContact = userContact.copy(name: contact.displayName);
              print('!!!!!!!!!!!!!!!!!!!!!!!!${contact.displayName}!!!!!!!!!!!!!!!!!!!');
              print('+++++++++++++++++++id:${userContact.id}+++++++++++++++++++++');
              print('++++++++++++++++++++++name:${userContact.name}++++++++++++++');
            });
            await UserPreferences.setUser(userContact);
            addItemToList();
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
}
