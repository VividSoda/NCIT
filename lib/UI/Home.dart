import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:rakshak_test/Contacts/add_emergency_contact.dart';
import 'package:rakshak_test/Maps/map_page.dart';
import 'package:rakshak_test/Siren/Siren.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var _selectedState = 1;
  var _screens = [];

  @override
  void initState(){
    super.initState();
    _screens = [
      const SirenPage(),
      const MapPage(),
       AddPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      body: SafeArea(
        child: _screens[_selectedState],
      ),

      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
          selectedItemColor: Colors.deepPurpleAccent,
          items:const [
            BottomNavigationBarItem(
                icon: Icon(Linecons.sound),
              label: "Siren"
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map"
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: "Emergency Contacts"
            )
          ],

        currentIndex: _selectedState,
        onTap: (index) {
          setState(() {
            _selectedState = index;
          });
        },
      ),
    );
  }
}
