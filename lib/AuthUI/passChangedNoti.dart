import 'package:flutter/material.dart';
import 'package:umbrella_care/AuthUI/login_page.dart';

class PassChangedNoti extends StatelessWidget {
  const PassChangedNoti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: const Text(
                    'Password changed',
                    style: TextStyle(
                        color: Color(0xFF5E1A84),
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Your password has been changed',
                  style: TextStyle(
                      color: Color(0xFF5E1A84),
                      fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'successfully',
                  style: TextStyle(
                    color: Color(0xFF5E1A84),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 40),


                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E1A84),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: const Text(
                      'Back to login',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
