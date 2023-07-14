import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umbrella_care/Doctor/doctorHome.dart';
import 'package:umbrella_care/Patient/patientHome.dart';
import 'package:umbrella_care/AuthUI/selectionScreen.dart';
import 'package:umbrella_care/navBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  // String userType = '';

  // void checkUserType(){
  //   print('check User Type+++++');
  //   final user = FirebaseAuth.instance.currentUser;
  //
  //   FirebaseFirestore.instance.collection('doctors').doc(user!.uid).get().then((value) {
  //     if(value.exists){
  //       print('userType = doctors');
  //       setState(() {
  //         userType = 'doctors';
  //       });
  //     }
  //
  //     else{
  //       print('userType = patients');
  //       setState(() {
  //         userType = 'users';
  //       });
  //     }
  //   }
  //   );
  // }

  // Future<void> checkUserType() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   print('checkUser555');
  //   if (user != null) {
  //     final doctorData = await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
  //     if(doctorData.exists){
  //       print('Doctor@@@@@@');
  //       setState(() {
  //         userType = 'doctor';
  //       });
  //     }
  //
  //     final patientData = await FirebaseFirestore.instance.collection('patients').doc(user.uid).get();
  //     if(patientData.exists){
  //       print('patients@@@@@@');
  //       setState(() {
  //         userType = 'patient';
  //       });
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );
    _animationController!.forward();

    Future.delayed(const Duration(seconds: 3), () {
      _animationController!.stop();
      setState(() {});
    });


    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // builder: (_) => const SelectionPage(),
            builder: (_) => StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return const NavBar();
                    }
                    else{
                      return const SelectionPage();
                    }
                  }
              ),
                // FutureBuilder<String?>(
                // future: checkUserType(),
                // builder: (context, snapshot) {
                //   final userType = snapshot.data;
                //
                //   print('has Data++++++');
                //
                //   if (userType == "doctor") {
                //     return const DoctorHome();
                //   } else {
                //     return const PatientHome();
                //   }
                // }
            //     // )
            //     StreamBuilder<User?>(
            //   stream: Auth().authStateChanges,
            //     builder: (context, snapshot) {
            //       if(snapshot.hasData){
            //         return
            //         FutureBuilder<void>(
            //         future: checkUserType(),
            //         builder: (context, snapshot) {
            //           print('has Data++++++');
            //           print(userType+'##########');
            //           if (userType == "doctor") {
            //             return const DoctorHome();
            //           }
            //           else {
            //             return const PatientHome();
            //           }
            //         }
            //         );
            //       }
            //       //   print('has Data++++++');
            //       //
            //       //   if(userType == "doctor"){
            //       //     return const DoctorHome();
            //       //   }
            //       //
            //       //   else{
            //       //     return const PatientHome();
            //       //   }
            //       // }
            //       else{
            //         return const SelectionPage();
            //       }
            //     }
            // )
        ),
      );
    });
  }


  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation!,
                child: Image.asset(
                  'assets/logos/UmbrellaCare.png',
                  width: 250,
                  height: 250,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
