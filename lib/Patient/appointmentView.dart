import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:umbrella_care/BlankRedirect.dart';
import 'package:umbrella_care/Constants/colors.dart';
import 'package:umbrella_care/Payment/paymentOptions.dart';

class AppointmentView extends StatefulWidget {
  final String uid;
  const AppointmentView({Key? key, required this.uid}) : super(key: key);

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  List<int> _appointmentTimes = [];
  List<int> _disabledTime = [];
  int _selectTime = 0;
  List<String> _bookedPatients = [];
  int _noOfCheckedPatients = 0;

  //add appointment data to doctor
  Future<void> appointDoctor() async{
    final db = FirebaseFirestore.instance;
   String appointmentID = _currentDay.toString();

    // print('#############################');
    // print(widget.uid);
    // print(_currentDay);
    // print(_appointmentTime);


    db.collection('doctors').doc(widget.uid).collection('appointments').doc(appointmentID).set(
        {
            'date' : _currentDay,
            'time' : _appointmentTimes,
          // 'patient id' : _currentUser!.uid
          'patient ids' : _bookedPatients
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
    }
    ).catchError((error) {
      print("Failed to update user: $error");
    });
  }

  //add appointment data to patient
  Future<void> bookAppointment() async{
    final db = FirebaseFirestore.instance;
    String appointmentID = _currentDay.toString();

    // print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    // print(_currentUser!.uid);
    // print(_currentDay);
    // print(_appointmentTime);

    db.collection('patients').doc(_currentUser!.uid).collection('appointments').doc(appointmentID).set(
      {
        'date' : _currentDay,
        'time' : _selectTime,
        // 'time' : _appointmentTimes,
        'doctor id' : widget.uid
      }
    ).then((value) {
      print('data added to patient successfully^^^^^^');
    }).catchError((error){
      print("Failed to update user: $error");
    });
  }

  //fetch appointment time from firebase
  Future<void> bookedTimes() async {
    final db = FirebaseFirestore.instance;

    List<int> _bookedTimes = [];

    final userDoc = db.collection('doctors').doc(widget.uid).collection('appointments').doc(_currentDay.toString());
    DocumentSnapshot<Map<String, dynamic>> snapshot = await userDoc.get();

    if(snapshot.exists){
      Map<String, dynamic> data = snapshot.data()!;

      List<dynamic> timeList = data['time'];
      _bookedTimes = timeList.cast<int>();

      // print(_bookedTimes.toString()+'******************');
      setState(() {
        _disabledTime = _bookedTimes;
        _appointmentTimes = _disabledTime;
      });
    }

    else{
      setState(() {
        _disabledTime = [];
        _appointmentTimes = [];
      });
    }
  }

  //fetch appointed patients from firebase
  Future<void> bookedPatients() async {
    final db = FirebaseFirestore.instance;

    List<String> bookedPatients = [];

    final userDoc = db.collection('doctors').doc(widget.uid).collection('appointments').doc(_currentDay.toString());
    DocumentSnapshot<Map<String, dynamic>> snapshot = await userDoc.get();

    if(snapshot.exists){
      Map<String, dynamic> data = snapshot.data()!;

      List<dynamic> patientList = data['patient ids'];
      bookedPatients = patientList.cast<String>();

      print(_bookedPatients.toString()+'******************patients');
      setState(() {
       _bookedPatients = bookedPatients;
      });
    }

    else{
      setState(() {
        _bookedPatients = [];
      });
    }
  }

  //fetch no of checked patients from firebase
  Future<void> fetchNumber() async{
    final user = FirebaseFirestore.instance.collection('doctors').doc(widget.uid);
    DocumentSnapshot<Map<String, dynamic>> snapshot = await user.get();
    Map<String, dynamic> data = snapshot.data()!;

    if(data['qualifications']!=null){
      _noOfCheckedPatients = data['no_of_checked_patients'];
      print('&&&&&&&&&&&&&&&&&$_noOfCheckedPatients');
    }
  }

  Future<void> updateNumber() async{
    final user = FirebaseFirestore.instance.collection('doctors').doc(widget.uid);

    setState(() {
      _noOfCheckedPatients++;
    });

    return user.update({
      'no_of_checked_patients' : _noOfCheckedPatients
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              //Back Button
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        border: Border.all(color: greyBorders),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: primary
                      ),
                    ),
                  ),

                  const SizedBox(width: 60),

                  const Text(
                    'Appointment',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: primary
                    ),
                  )
                ],
              ),

              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          //display table calender here
                          _tableCalendar(),

                          //Time Text
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Center(
                              child: Text(
                                'Time',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: primary
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    //Time
                    _isWeekend? SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        alignment: Alignment.center,
                        child: const Text(
                          'Weekend is not available, please select another date',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red
                          ),
                        ),
                      ),
                    ) : SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          print(_disabledTime.toString());
                          bool isDisabled = _disabledTime.contains(index+9);
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: isDisabled? null : (){
                              setState(() {
                                _currentIndex = index;
                                _timeSelected = true;
                                _selectTime = index+9;
                                // _appointmentTime = index+9;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isDisabled? Colors.grey : _currentIndex == index? Colors.white : Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: isDisabled? Colors.grey : _currentIndex == index? primary : null
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 9} : 00 ${index + 9 > 11 ? "PM" : "AM"}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _currentIndex == index ? Colors.white : null
                                ),
                              ),
                            ),
                          );
                        },
                            childCount: 8
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1.5
                        )
                    ),

                    //Proceed Button
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isWeekend? null : (){
                              if(_dateSelected == false){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Select Date!!!',
                                        )
                                    )
                                );
                              }

                              if(_dateSelected == true && _timeSelected == false){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Select Time!!!',
                                        )
                                    )
                                );
                              }


                              if(_dateSelected == true && _timeSelected == true){
                                setState(() {
                                  _appointmentTimes.add(_selectTime);
                                  _bookedPatients.add(_currentUser!.uid);
                                });
                                bookAppointment();
                                appointDoctor();
                                updateNumber();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>PaymentOptions(uid: widget.uid))
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5E1A84),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            child: const Text(
                              'Proceed',
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),

                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //table calendar
  Widget _tableCalendar(){
    return Container(
      height: 380,
      child: TableCalendar(
          focusedDay: _focusDay,
          firstDay: DateTime.now(),
          lastDay: DateTime(2023, 12, 31),
        calendarFormat: _format,
        currentDay: _currentDay,
        rowHeight: 48,
        calendarStyle:  const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: primary,
            shape: BoxShape.circle,
          ),
        ),
        // headerStyle: const HeaderStyle(
        //   // formatButtonVisible: false,
        //   // titleCentered: true,
        //   // titleTextStyle: TextStyle(
        //   //   fontSize: 34,
        //   //   fontWeight: FontWeight.w800,
        //   //   color: primary
        //   // ),
        //
        // ),
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, date) {
            final monthText = DateFormat.MMMM().format(date); // Get the month text
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Text(
                  monthText,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: primary, // Customize the month text color here
                  ),
                ),
              ),
            );
          },
        ),
        availableCalendarFormats: const {
            CalendarFormat.month : 'Month'
        },
        onFormatChanged: (format){
            setState(() {
              _format = format;
            });
        },
        onDaySelected: ((selectedDay, focusedDay){
          setState(() {
            _currentDay = selectedDay;
            _focusDay = focusedDay;
            _dateSelected = true;

            //check is weekend is selected
            if(selectedDay.weekday == 6 || selectedDay.weekday == 7){
              _isWeekend = true;
              _timeSelected = false;
              _currentIndex = null;
            }
            else{
              _isWeekend = false;
              bookedTimes();
              bookedPatients();
            }
          });
        }
        ),
      ),
    );
  }
}


