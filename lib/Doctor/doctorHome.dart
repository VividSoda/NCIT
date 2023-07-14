import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umbrella_care/AuthUI/login_page.dart';
import 'package:umbrella_care/BlankRedirect.dart';
import 'package:umbrella_care/Constants/colors.dart';
import 'package:umbrella_care/Doctor/doctorProfile.dart';
import 'package:umbrella_care/Doctor/doctorReport.dart';
import 'package:umbrella_care/Doctor/editDoctorProfile.dart';
import 'package:umbrella_care/Doctor/patientSearch.dart';
import 'package:umbrella_care/Doctor/reviewsPage.dart';
import 'package:umbrella_care/Models/Doctor/patientAppointmentInfo.dart';
import 'package:umbrella_care/Models/appointmentModelTest.dart';
import 'package:umbrella_care/Patient/patientReport.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  List<PatientAppointmentInfo> appointments =  [];
  final currentUser = FirebaseAuth.instance.currentUser;
  final _pageController = PageController(viewportFraction: 0.877);
  final user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;
  final DateTime _currentDate = DateTime.now();
  String _imgUrl = '';

  //Fetch user details from firebase
  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchUserDetails() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    print(currentUser!.uid+'dafasdfadfsa');

    if(currentUser!=null){
      final userDoc =
      FirebaseFirestore.instance.collection('doctors').doc(currentUser!.uid);
      return await userDoc.get();
    }
    return null;
  }

  //get all appointment list from firebase
  Future<List<PatientAppointmentInfo>> getAppointmentsFromFirebase() async {
    List<PatientAppointmentInfo> appointments = [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('doctors').doc(user!.uid).collection('appointments').get();

    for (var doc in snapshot.docs) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      Timestamp timestamp = data!['date'];
      List<dynamic> dynamicList = data['time'];
      List<dynamic> dynamicList2 = data['patient ids'];

      DateTime appointmentDate = timestamp.toDate();

      //compare date and then proceed
      bool showAppointment = appointmentDate.isAtSameMomentAs(_currentDate) || appointmentDate.isAfter(_currentDate);

      if(showAppointment==true){
        // String patientId = dynamicList2[0];
        List<String> patientIds = dynamicList2.cast<String>();
        List<int> appointmentTimes = dynamicList.cast<int>();
        // appointmentTimes.sort();

        int listLength = patientIds.length;
        // int listLength = appointmentTimes.length;

        List<PatientAppointmentInfo> miniAppointments = [];
        int counter = 0;

        for(int i = 0; i<listLength; i++){
          int index = appointmentTimes.indexOf(appointmentTimes[i]);
          print('asaas++++++++++${appointmentTimes[index]} , ${patientIds[index]}');
          //print(patientIds[index]);
          Map<String, String>? patientDetails = await fetchPatientDetails(patientIds[i]);
          //Map<String, String>? patientDetails = await fetchPatientDetails(patientIds[index]);

          if (patientDetails != null) {
            String name = patientDetails['name']!;
            String contact = patientDetails['contact']!;


            PatientAppointmentInfo appointmentInfo = PatientAppointmentInfo(
                appointmentDate: appointmentDate,
                name: name,
                contact: contact,
                // bookedTimes: appointmentTime
                // bookedTimes: appointmentTimes
                bookedTime: appointmentTimes[i]
            );
            miniAppointments.add(appointmentInfo);
            counter++;
            // appointments.add(appointmentInfo);
          }
          else {
            print('Patient details not found');
          }
        }

        print('$counter^^^^^^^^^^^');

        if(counter==listLength){
          miniAppointments.sort((a, b) => a.bookedTime.compareTo(b.bookedTime));
          appointments.addAll(miniAppointments);
        }
      }//for loop
    }
    return appointments;
  }

  //fetch patient details from firebase
  Future<Map<String, String>?> fetchPatientDetails(String uid) async{
    final docData = FirebaseFirestore.instance.collection('patients').doc(uid);

    DocumentSnapshot<Map<String, dynamic>> snapshot = await docData.get();

    if(snapshot.exists){
      Map<String, dynamic> data = snapshot.data()!;

      String name = data['name'];
      String contact = data['contact'];

      return {'name' : name, 'contact' : contact};
    }
    return null;
  }

  //assign appointment list
  Future<void> fetchAppointments() async {
    List<PatientAppointmentInfo> fetchedAppointments = await getAppointmentsFromFirebase();
    setState(() {
      appointments = fetchedAppointments;
      _isLoading = false;
    });
    print(appointments[0].name+'fetched%%%%%%%%%');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAppointments();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool listItemsExist = appointments.isNotEmpty;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
                        future: fetchUserDetails(),
                        builder: (context, snapshot){
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData) {
                            return const Text('No user data found.');
                          }

                          final user = snapshot.data!.data();
                          final name = user!['name'];
                          if(user['img url']!=null){
                            _imgUrl = user['img url'];
                          }
                          print(user!['name']);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '👋 Hello',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5E1A84)
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'Dr. $name',
                                style: const TextStyle(
                                    fontSize: 27,
                                    color: Color(0xFF5E1A84),
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          );
                        },
                      ),

                      //Profile Button
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                              MaterialPageRoute(builder: (context) => const DoctorProfile())
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 52,
                              height: 52,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: _imgUrl==''? Image.asset(
                                    'assets/doctorImages/doctorPic.png'
                                ) : Image.network(
                                    _imgUrl
                                ),
                              ),
                            )
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  //Search
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PatientSearch())
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFF5E1A84)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                decoration: const InputDecoration(
                                  hintText: 'What are you looking for?',
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Color(0xFF5E1A84),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {

                                },
                                icon: Image.asset(
                                    'assets/logos/Filter.png'
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Services',
                    style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF5E1A84),
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Doctor Button
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const DoctorProfile())
                              );
                            },
                            child: Container(
                              height: 71,
                              width: 71,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFD6F6FF)
                              ),
                              child: Image.asset('assets/logos/Doctor.png'),
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF5E1A84),
                            ),
                          )
                        ],
                      ),

                      const Spacer(),

                      //Record Button
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const DoctorReport())
                              );
                            },
                            child: Container(
                              height: 71,
                              width: 71,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFD6F6FF)
                              ),
                              child: Image.asset('assets/logos/Record.png'),
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            'Patients',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF5E1A84),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      //Reviews Button
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  // MaterialPageRoute(builder: (context) => const ReviewsPage())
                                  MaterialPageRoute(builder: (context) => ReviewsPage(uid: currentUser!.uid))
                              );
                            },
                            child: Container(
                              height: 71,
                              width: 71,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFD6F6FF)
                              ),
                              child: Image.asset('assets/logos/review.png'),
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            'Reviews',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF5E1A84),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 176,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: fadedPrimary
                    ),

                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                          'Ad Placement',
                          style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white
                          )
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Upcoming Appointments',
                    style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF5E1A84),
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(height: 20),

                  //Upcoming Appointments
                  Container(
                    height: 120,
                    child: _isLoading? const Center(
                      child: CircularProgressIndicator(),
                    ) : listItemsExist? PageView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        children: List.generate(
                            appointments.length>4? 4 : appointments.length,
                            // appointments.length,
                                (int index) {
                              // String dayOfWeek = DateFormat('EEEE').format(appointments[index].appointment);
                              // String formattedTime = DateFormat('h:mm a').format(appointments[index].appointment);


                                  String dayOfWeek = DateFormat('EEEE').format(appointments[index].appointmentDate);
                                  //String formattedTime = '${appointments[index].bookedTimes[0]} : 00 ${appointments[index].bookedTimes[0] > 11 ? "PM" : "AM"}';
                                  // String formattedTime = '${appointments[index].bookedTimes[0]} : 00 ${appointments[index].bookedTimes[0] > 11 ? "PM" : "AM"}';
                                  String formattedTime = '${appointments[index].bookedTime} : 00 ${appointments[index].bookedTime > 11 ? "PM" : "AM"}';

                                  return Container(
                                margin: const EdgeInsets.only(right: 28),
                                height: 120,
                                width: 282,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFF5E1A84),
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${appointments[index].appointmentDate.day}',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                              decoration: TextDecoration.underline,
                                              decorationColor: Colors.white,
                                              decorationThickness: 2
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        Text(
                                          dayOfWeek,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              decoration: TextDecoration.underline,
                                              decorationColor: Colors.white,
                                              decorationThickness: 2
                                          ),
                                        ),
                                      ],
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          formattedTime,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),

                                        const SizedBox(height: 5),

                                        Text(
                                          appointments[index].name,
                                          style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),

                                        const SizedBox(height: 5),


                                        Text(
                                          appointments[index].contact,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                        )
                    ) : const Center(
                      child: Text(
                        'No upcoming appointments',
                        style: TextStyle(
                            fontSize: 18,
                            color: primary,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
