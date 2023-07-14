import 'dart:async';

import 'package:flutter/material.dart';
import 'package:umbrella_care/AuthUI/login_page.dart';
import 'package:umbrella_care/AuthUI/resetPassword.dart';

class SendCode extends StatefulWidget {
  const SendCode({Key? key}) : super(key: key);

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  bool isCounting = false;
  int countdownTime = 30; // Countdown time in seconds
  Timer? _timer;

  void startCountdownTimer() {
    setState(() {
      isCounting = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownTime > 0) {
         countdownTime--;
        } else {
          _timer!.cancel();
          countdownTime = 30;
          startCountdownTimer();
        }
      });
    });
  }


  String getFormattedTime() {
    int minutes = countdownTime ~/ 60;
    int seconds = countdownTime % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startCountdownTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                //Back Button
                Container(
                  width: 39,
                  height: 39,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF5E1A84),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                const Text(
                  'Reset password',
                  style: TextStyle(
                      color: Color(0xFF5E1A84),
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'We have send a code to usermail@gmail.com',
                  style: TextStyle(
                      color: Color(0xFF5E1A84),
                      fontSize: 16
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ConfirmationCodeBox(),
                    ConfirmationCodeBox(),
                    ConfirmationCodeBox(),
                    ConfirmationCodeBox(),
                  ],
                ),

                const SizedBox(height: 40),

                //Verify Button
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) => const ResetPassword())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E1A84),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Send code Again',
                      style: TextStyle(
                        color: Color(0xFF5E1A84),
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      isCounting ? '00 : ${countdownTime}' : '00 : 00',
                      style: const TextStyle(
                        color: Color(0xFF5E1A84),
                       fontSize: 16
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}

class ConfirmationCodeBox extends StatefulWidget {
  const ConfirmationCodeBox({Key? key}) : super(key: key);

  @override
  State<ConfirmationCodeBox> createState() => _ConfirmationCodeBoxState();
}

class _ConfirmationCodeBoxState extends State<ConfirmationCodeBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 77,
      height: 77,
      child: TextField(
        controller: _controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
