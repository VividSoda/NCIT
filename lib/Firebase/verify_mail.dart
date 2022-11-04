import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rakshak_test/UI/Home.dart';
import 'package:rakshak_test/UI/LoginPage.dart';

class VerifyMailPage extends StatefulWidget {
  const VerifyMailPage({Key? key}) : super(key: key);

  @override
  State<VerifyMailPage> createState() => _VerifyMailPageState();
}

class _VerifyMailPageState extends State<VerifyMailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail=false);
      await Future.delayed(const Duration(seconds :5));
      setState(()=>canResendEmail= true);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Scaffold(
    backgroundColor: Colors.grey[300],
    appBar: AppBar(
      backgroundColor: Colors.deepPurple,
      leading: const Icon(Icons.email_rounded),
      title: const Text('Verify Mail'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Please Check Your Email',
              style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 24
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'A verification email has been sent',
            style: TextStyle(
                fontFamily: 'BebasNeue',
              fontSize: 20
               ),
          ),
          const SizedBox(height: 24),

          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              onPressed: (){sendVerificationEmail();},
              icon: const Icon(
                Icons.email_rounded,
                size: 32,
              ),
              label: const Text(
                'Resend Email',
                style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontWeight: FontWeight.bold
                ),
              )
          ),

          TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.deepPurple
              ),
              onPressed: () =>FirebaseAuth.instance.signOut().then((value) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> const LoginPage()
                )
            );
          }), child: const Text(
              'Cancel',
            style: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 1
            ),
          )
          )
        ],
      ),
    ),
  );
}
