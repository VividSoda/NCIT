import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditPatientProfile extends StatefulWidget {
  const EditPatientProfile({Key? key}) : super(key: key);

  @override
  State<EditPatientProfile> createState() => _EditPatientProfileState();
}

class _EditPatientProfileState extends State<EditPatientProfile> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool _isEnabled = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  String? selectedBloodGroup;
  final TextEditingController _weight= TextEditingController();
  int? selectedFeet;
  int? selectedInches;
  bool _isLoading = true;

  String? name = '';
  String? uid = '';

  Uint8List? _profileImage;
  String _imgUrl = '';

  //Blood Groups
  List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  //Feet Lists
  List<DropdownMenuItem<int>> buildDropdownFeetItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int i = 4; i <= 10; i++) {
      items.add(DropdownMenuItem<int>(
        value: i,
        child: Text('$i feet'),
      ));
    }
    return items;
  }

  //Inches List
  List<DropdownMenuItem<int>> buildDropdownInchesItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int i = 0; i <= 11; i++) {
      items.add(DropdownMenuItem<int>(
        value: i,
        child: Text('$i inches'),
      ));
    }
    return items;
  }


  //get user details form firebase
  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchUserDetails() async {
    print(currentUser!.uid+'dafasdfadfsa');

    if(currentUser!=null){
      final userDoc =
      FirebaseFirestore.instance.collection('patients').doc(currentUser!.uid);

      DocumentSnapshot<Map<String, dynamic>> snapshot = await userDoc.get();

      if(snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;

        name = data['name'];
        uid = currentUser!.uid;

        if (data['contact'] != null) {
          _contact.text = data['contact'];
        }

        if(data['dob']!=null){
          _dob.text = data['dob'];
        }

        if(data['blood group']!=null){
          print('fxn call for blood grp');
          selectedBloodGroup = data['blood group'];
        }

        if(data['weight']!=null){
          _weight.text = data['weight'];
        }

        if(data['height'] != null && data['height']['feet']!=null){
          selectedFeet = data['height']['feet'];
        }

        if(data['height'] != null && data['height']['inches']!=null){
          selectedInches = data['height']['inches'];
        }

        if(data['img url']!=null){
          _imgUrl = data['img url'];
        }
      }

      setState(() {
        _isLoading =false;
      });
      return await userDoc.get();
    }

    setState(() {
      _isLoading = false;
    });
    return null;
  }

  //Update data to firebase
  Future<void> submitData() async{
    final db = FirebaseFirestore.instance;

    return db.collection('patients').doc(currentUser!.uid).update(
        {
          'contact' : _contact.text,
          'dob' : _dob.text,
          'blood group' : selectedBloodGroup,
          'weight' : _weight.text,
          'height' : {
            'feet' : selectedFeet,
            'inches' : selectedInches,
          },
          'validity' : true,
          'img url' : _imgUrl
        }
    ).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Data updated successfully',
              )
          )
      );

      Navigator.of(context).pop();
    }
    ).catchError((error) {
      print("Failed to update user: $error");
    });
  }

  //pick Image
  Future<void> pickImage() async{
    try{
      final ImagePicker imagePicker = ImagePicker();

      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

      if(file!=null){
        Uint8List img = await file.readAsBytes();

        setState(() {
          _profileImage = img;
        });
      }
    }

    catch(e){
      print('XXXXXXXXXXXXXXXX--$e--XXXXXXXXXXXX');
    }
  }

  //upload image
  Future<void> uploadImage() async{

    if(_profileImage==null) return;

    final destination = 'profilePictures/patients/${currentUser!.uid}';

    try{
      final ref = FirebaseStorage.instance.ref(destination);

      await ref.putData(_profileImage!);

      ref.getDownloadURL().then((value) {
        _imgUrl = value;
      });
    }

    on FirebaseException catch(e){
      print('+++++$e');
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUserDetails();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _contact.dispose();
    _dob.dispose();
    _weight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5E1A84),
              Color(0xFF5E1A84),
              Color(0xFFD9D9D9),
              Color(0xFFD9D9D9),
            ],
            stops: [0.0, 0.25, 0.25, 1.0],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: _isLoading? const Center(
              child: CircularProgressIndicator()
          ) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                //Back Button
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white
                        ),
                      ),
                    ),

                    const SizedBox(width: 60),

                    const Text(
                      'Patient Details',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 30),

                //Profile Container
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                      children : [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: 319,
                            height: 109,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Image
                                GestureDetector(
                                  onTap: _isEnabled? (){
                                    pickImage();
                                  } : null,
                                  child: SizedBox(
                                    width: 77,
                                    height: 77,
                                    child: _imgUrl!=''? ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        _imgUrl
                                      )
                                    ) : _profileImage!=null? ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.memory(
                                          _profileImage!
                                        ),
                                    ) : Image.asset(
                                          'assets/patientImages/patient.png'
                                      ),
                                    // child: Image.asset(
                                    //   'assets/patientImages/ProfilePic.png',
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                ),

                                const Spacer(),


                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      name!,
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF5E1A84)
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    const Text(
                                      'User ID',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF5E1A84)
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      uid!,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF5E1A84)
                                      ),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),

                                const Spacer()
                              ],
                            )
                        ),

                        //Edit Button
                        Positioned(
                            right: 5,
                            child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _isEnabled = !_isEnabled;
                                  });
                                },
                                icon: const Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFF5E1A84)
                                )
                            )
                        )
                      ]
                  ),
                ),

                const SizedBox(height: 50),

                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Contact Info
                            const Text(
                              'Contact Number',
                              style: TextStyle(
                                  color: Color(0xFF5E1A84),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400
                              ),
                            ),

                            const SizedBox(height: 10),

                            //Contact Info
                            Container(
                              height: 43,
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Enter Contact Number!!!";
                                  }

                                  else if(value.length!=10){
                                    return "Contact number should be 10 digits!!!";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                controller: _contact,
                                enabled: _isEnabled,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Contact Number',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF5E1A84)
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF5E1A84)
                                      )
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            //Date of Birth
                            const Text(
                              'Date of Birth',
                              style: TextStyle(
                                  color: Color(0xFF5E1A84),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400
                              ),
                            ),

                            const SizedBox(height: 10),

                            //Date of Birth
                            Container(
                              height: 43,
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Field must be filled!!!";
                                  }
                                  else {
                                    try {
                                      // Parse the entered date
                                      DateFormat('dd/MM/yyyy').parseStrict(value);
                                      return null; // Return null if the date is valid
                                    } catch (e) {
                                      return 'Invalid date format! Please enter a valid date (DD/MM/YYYY).';
                                    }
                                  }
                                },
                                controller: _dob,
                                enabled: _isEnabled,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                  _DateInputFormatter(),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Date of Birth (DD/MM/YYYY)',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF5E1A84)
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF5E1A84)
                                      )
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            //Blood Group
                            const Text(
                              'Blood Group',
                              style: TextStyle(
                                  color: Color(0xFF5E1A84),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400
                              ),
                            ),

                            const SizedBox(height: 10),

                            //Blood Group
                            Container(
                              height: 45,
                              child: DropdownButtonFormField(
                                value: selectedBloodGroup,
                                onChanged: (String? newValue) {
                                  // Update the selected option
                                  setState(() {
                                    selectedBloodGroup = newValue;
                                  });
                                },
                                validator: (value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please select an option';
                                  }
                                  // if(value!.isEmpty){
                                  //   return "Blood Group must be filled!!!";
                                  // }
                                  else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Blood Group',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF5E1A84)
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF5E1A84)
                                      )
                                  ),
                                ),
                                items: bloodGroups.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black
                                ),
                                isExpanded: true,
                              ),
                            ),

                            const SizedBox(height: 20),

                            //Weight
                            const Text(
                              'Weight',
                              style: TextStyle(
                                  color: Color(0xFF5E1A84),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400
                              ),
                            ),

                            const SizedBox(height: 10),

                            //Weight
                            Container(
                              height: 43,
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Field cannot be empty!!!";
                                  }

                                  else{
                                    return null;
                                  }
                                },
                                controller: _weight,
                                enabled: _isEnabled,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Weight (in Kgs)',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF5E1A84)
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF5E1A84)
                                      )
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            //Height
                            const Text(
                              'Height',
                              style: TextStyle(
                                  color: Color(0xFF5E1A84),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400
                              ),
                            ),

                            const SizedBox(height: 10),

                            //Height
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Feet
                                Container(
                                  height: 45,
                                  width: 153,
                                  child: DropdownButtonFormField<int>(
                                    value: selectedFeet,
                                    onChanged: (int? newValue) {
                                      // Update the selected option
                                      setState(() {
                                        selectedFeet = newValue;
                                      });
                                    },
                                    validator: (value){
                                      if (value == null) {
                                        return 'Please select an option';
                                      }

                                      else{
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Feet',
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF5E1A84)
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF5E1A84)
                                          )
                                      ),
                                    ),
                                    items: buildDropdownFeetItems(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                    isExpanded: true,
                                  ),
                                ),

                                const Spacer(),

                                //Inches
                                Container(
                                  height: 45,
                                  width: 153,
                                  child: DropdownButtonFormField<int>(
                                    value: selectedInches,
                                    onChanged: (int? newValue) {
                                      // Update the selected option
                                      setState(() {
                                        selectedInches = newValue;
                                      });
                                    },
                                    validator: (value){
                                      if (value == null) {
                                        return 'Please select an option';
                                      }
                                      // if(value!.isEmpty){
                                      //   return "Blood Group must be filled!!!";
                                      // }
                                      else{
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Inches',
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF5E1A84)
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF5E1A84)
                                          )
                                      ),
                                    ),
                                    items: buildDropdownInchesItems(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                    isExpanded: true,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            //Submit Button
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 56,
                              child: (_profileImage!=null)? FutureBuilder<void>(
                                future: uploadImage(),
                                builder: (context, snapshot){
                                  if(snapshot.connectionState==ConnectionState.waiting){
                                    return const Center(
                                        child: CircularProgressIndicator()
                                    );
                                  }

                                  return ElevatedButton(
                                    onPressed: () async{
                                      if(_profileImage!=null){
                                        await uploadImage();
                                      }

                                      if(_formKey.currentState!.validate()){
                                        print('submit successful');
                                        submitData();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF5E1A84),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    ),
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontSize: 18
                                      ),
                                    ),
                                  );
                                },
                              ) : ElevatedButton(
                                onPressed: ()async{
                                  if(_formKey.currentState!.validate()){
                                    submitData();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5E1A84),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
          ),
          // child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
          //   future: fetchUserDetails(),
          //   builder: (context, snapshot){
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Align(
          //           alignment: Alignment.center,
          //           child: CircularProgressIndicator()
          //       );
          //     }
          //     if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     }
          //     if (!snapshot.hasData) {
          //       return const Text('No user data found.');
          //     }
          //
          //     final user = snapshot.data!.data();
          //     final name = user!['name'];
          //     final uid = currentUser!.uid;
          //     print(user!['name']);
          //
          //     return
          //   },
          // ),
        ),
      ),
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newText = _addSlashes(newValue.text);
    return newValue.copyWith(
        text: newText, selection: _updateCursorPosition(newValue, newText));
  }

  TextSelection _updateCursorPosition(
      TextEditingValue newValue, String newText) {
    final diff = newText.length - newValue.text.length;
    final selectionStart = newValue.selection.baseOffset + diff;
    final selectionEnd = newValue.selection.extentOffset + diff;
    return TextSelection.collapsed(
        offset: selectionStart, affinity: newValue.selection.affinity);
  }

  String _addSlashes(String text) {
    text = text.replaceAll("/", ""); // Remove existing slashes

    if (text.length > 2) {
      text = text.substring(0, 2) + "/" + text.substring(2);
    }
    if (text.length > 5) {
      text = text.substring(0, 5) + "/" + text.substring(5);
    }
    return text;
  }
}
