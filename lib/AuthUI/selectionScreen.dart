import 'package:flutter/material.dart';
import 'package:umbrella_care/AuthUI/doctorRegistration.dart';
import 'package:umbrella_care/AuthUI/login_page.dart';
import 'package:umbrella_care/AuthUI/patientRegistration.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Logo
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/logos/UmbrellaCare.png',
                            ),
                          ),

                          const SizedBox(height: 40),

                          //Text
                          const Text(
                            'Simple Healthcare',
                            style: TextStyle(
                                fontSize: 37,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5E1A84)
                            ),
                          ),

                          const SizedBox(height: 5),

                          //Text
                          const Text(
                            'Trust us with your precious health',
                            style: TextStyle(
                                color: Color(0xFF5E1A84),
                                fontSize: 18
                            ),
                          ),

                          const SizedBox(height: 5),

                          //Text
                          const Text(
                            'Lifestyle',
                            style: TextStyle(
                                color: Color(0xFF5E1A84),
                                fontSize: 18
                            ),
                          ),

                          const SizedBox(height: 40),

                          //Patient Button
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const PatientRegistration())
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5E1A84),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                              child: const Text(
                                'As a patient',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          //Docotor Button
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const DoctorRegistration())
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  side: const BorderSide(
                                      color: Color(0xFF5E1A84)
                                  )
                              ),
                              child: const Text(
                                'As a doctor',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF5E1A84)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child:  //Log in
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Color(0xFF5E1A84),
                              ),
                            ),

                            const SizedBox(width: 10),

                            InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage())
                                );
                              },
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  color: Color(0xFF5E1A84),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  decorationThickness: 2,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                  ),
          ),
        ),
    );
  }
}
