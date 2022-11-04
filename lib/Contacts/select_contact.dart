import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rakshak_test/Contacts/contact.class.dart';

class SelectContactPage extends StatefulWidget {
  const SelectContactPage({Key? key}) : super(key: key);

  @override
  State<SelectContactPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  TextEditingController searchController = TextEditingController();
  UserContact userContact = UserContact();


  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  Future<List<Contact>> getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = _contacts;
    });
    return contacts;
  }

  Future<List<Contact>> filterContacts() async {
    List<Contact> _filterContacts = [];
    _filterContacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _filterContacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName!.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }
        if (searchTermFlatten.isEmpty) {
          return false;
        }
        var phone = contact.phones!.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value!);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null!);
        return phone != null;
      });
    }
    setState(() {
      filteredContacts = _filterContacts;
    });
    return filteredContacts;
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist = (filteredContacts.isNotEmpty||!isSearching);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("Select Contact"),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children:[
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    prefixIcon: const Icon(Icons.search)
                ),
              ),

              FutureBuilder(
                future: isSearching? filterContacts() : getAllContacts(),
                builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot){
                  if(snapshot.hasData){
                    return listItemsExist == true? Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: isSearching == true? filteredContacts.length:contacts.length,
                          itemBuilder: (context, index){
                            Contact contact = isSearching == true? filteredContacts[index] : contacts[index];
                            return ListTile(
                              title: Text('${contact.displayName}'),
                              subtitle: Text(contact.phones!.isNotEmpty ? '${contact.phones!.elementAt(0).value}' : ''),
                              leading: (contact.avatar != null && contact.avatar!.isNotEmpty)?
                              CircleAvatar(backgroundImage: MemoryImage(contact.avatar!)) :
                              CircleAvatar(
                                  backgroundColor: Colors.deepPurple,
                                  child: Text(contact.initials())
                              ),
                              onTap: () async {
                                // await UserPreferences.setUser(contact);
                                Navigator.pop(context, isSearching? filteredContacts[index] : contacts[index]);
                              },
                            );
                          }
                      ),
                    ): Container(
                        padding:const EdgeInsets.all(20),
                        child: const Text(
                            'No search results to show'
                        )
                    );
                  }
                  else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
