import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umbrella_care/Cards/Doctor/doctorAppointmentCard.dart';
import 'package:umbrella_care/Cards/scheduleButtons.dart';
import 'package:umbrella_care/Constants/colors.dart';
import 'package:umbrella_care/Models/Patient/doctorAppointmentInfo.dart';
import 'package:umbrella_care/Models/buttonModel.dart';
import 'package:umbrella_care/Patient/doctorSearch.dart';
import 'package:umbrella_care/navBar.dart';

class PatientSchedule extends StatefulWidget {
  const PatientSchedule({Key? key}) : super(key: key);

  @override
  State<PatientSchedule> createState() => _PatientScheduleState();
}

class _PatientScheduleState extends State<PatientSchedule> {
  final currentUser = FirebaseAuth.instance.currentUser;
  List<ButtonModel> buttons = [];
  bool _isButtonLoading = true;
  bool _isScheduleLoading = true;
  List<DoctorAppointmentInfo> appointments = [];
  // int _selectedButtonIndex = 0;
  final DateTime _currentDate = DateTime.now();

  // List<ButtonModel> _buttonLabels = [
  //   'Button 1',
  //   'Button 2',
  //   'Button 3',
  //   'Button 4',
  //   'Button 5',
  //   'Button 6',
  // ];

  //fetch buttons form firebase
  Future<List<ButtonModel>> getButtonsFromFirebase() async {
    List<ButtonModel> buttons = [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('patients').doc(currentUser!.uid).collection('appointments').get();

    for (var doc in snapshot.docs) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      String uid = doc.id;
      // print(uid + 'butttonsssssssss##########');
      DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(uid);
      // print(dateTime.toString() + 'butttonsssssssss##########');

      //compare date and then proceed
      bool showAppointment = dateTime.isAtSameMomentAs(_currentDate) || dateTime.isAfter(_currentDate);

      if(showAppointment==true){
        String day = DateFormat('d').format(dateTime);
        String weekName = DateFormat('EEE').format(dateTime);
        // print(day+'asdfadf'+weekName);

        ButtonModel buttonModel = ButtonModel(
            uid: uid,
            day: day,
            weekDay: weekName
        );
        buttons.add(buttonModel);
      }
    }
    return buttons;
  }

  //assign buttons list
  Future<void> fetchButtons() async {
    List<ButtonModel> fetchedButtons = await getButtonsFromFirebase();
    setState(() {
      buttons = fetchedButtons;
      if(buttons.isNotEmpty){
        buttons[0].isSelected = true;
        fetchAppointments(buttons[0].uid);
      }
      _isButtonLoading = false;
    });
  }

  //fetch schedule from firebase
  Future<List<DoctorAppointmentInfo>> getAppointmentInfo(String uid) async {
    List<DoctorAppointmentInfo> appointments = [];

    final appointment = await FirebaseFirestore.instance.collection('patients').doc(currentUser!.uid).collection('appointments').doc(uid);

    DocumentSnapshot<Map<String, dynamic>> snapshot = await appointment.get();

      Map<String, dynamic> data = snapshot.data()!;


      Timestamp timestamp = data!['date'];
      // List<dynamic> dynamicList = data['time'];

      DateTime appointmentDate = timestamp.toDate();
      String doctorId = data['doctor id'];
      int appointmentTime = data['time'];

      Map<String, String>? doctorDetails = await fetchDoctorDetails(doctorId);

      if (doctorDetails != null) {
        String name = doctorDetails['name']!;
        String specialization = doctorDetails['specialization']!;

        // Use the name and specialization variables here
        print('Doctor Name: $name');
        print('Specialization: $specialization');

        String imgUrl = doctorDetails['img url']!;

        DoctorAppointmentInfo appointmentInfo = DoctorAppointmentInfo(
            appointmentDate: appointmentDate,
            name: name,
            speciality: specialization,
            // bookedTimes: appointmentTime
            bookedTime: appointmentTime,
          imgUrl: imgUrl
        );
        appointments.add(appointmentInfo);
      }

      else {
        print('Doctor details not found');
      }

      return appointments;
  }

  //fetch doctor details from firebase
  Future<Map<String, String>?> fetchDoctorDetails(String uid) async{
    final docData = FirebaseFirestore.instance.collection('doctors').doc(uid);

    DocumentSnapshot<Map<String, dynamic>> snapshot = await docData.get();

    if(snapshot.exists){
      Map<String, dynamic> data = snapshot.data()!;

      String name = data['name'];
      String specialization = data['specialization'];
      String imgUrl = '';

      if(data.containsKey('img url')){
        imgUrl = data['img url']!;
        print('$imgUrl[][][][]');
      }

      return {'name' : name, 'specialization' : specialization, 'img url' : imgUrl};
    }
    return null;
  }

  //assign buttons list
  Future<void> fetchAppointments(String uid) async {
    List<DoctorAppointmentInfo> fetchedAppointments = await getAppointmentInfo(uid);
    setState(() {
      appointments = fetchedAppointments;
      // print(appointments.toString()+'((((((((((((((((((((');
      _isScheduleLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchButtons();
  }

  @override
  Widget build(BuildContext context) {
    bool buttonListExist = buttons.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavBar())
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: primary,
            )
        ),
        title: const Text(
          'Schedule',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
            color: primary
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Schedule Buttons
                  SizedBox(
                    height: 84,
                    child: _isButtonLoading? const Center(
                      child: CircularProgressIndicator(),
                    ) : buttonListExist? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: buttons.length,
                      itemBuilder: (context, index){
                        final button = buttons[index];
                        return ScheduleButtons(
                        button: button,
                        onPressed: () {
                          setState(() {
                            for (var b in buttons) {
                              b.isSelected = false;
                            }
                            button.isSelected = true;
                            fetchAppointments(button.uid);
                          });
                        },
                      );
                    },
                    ) : Column(
                      children: [
                        const Text(
                          'No Appointments Yet',
                          style: TextStyle(
                              fontSize: 20,
                              color: primary
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Book an Appointment',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: primary
                              ),
                            ),

                            const SizedBox(width: 10),

                            InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const DoctorSearch())
                                );
                              },
                              child: const Text(
                                'Here',
                                style: TextStyle(
                                  color: primary,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  decorationThickness: 2,
                                  fontSize: 20
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  //Appointment List
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: appointments.length,
                    itemBuilder: (context, index){
                      return DoctorAppointmentCard(appointment: appointments[index]);
                  },
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
