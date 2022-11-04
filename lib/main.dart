import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rakshak_test/Contacts/contact.preferences.dart';
import 'package:rakshak_test/Firebase/verify_mail.dart';
import 'package:rakshak_test/UI/Home.dart';
import 'package:rakshak_test/UI/LoginPage.dart';
import 'package:rakshak_test/UI/RegisterPage.dart';
import 'package:rakshak_test/Firebase/auth_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context, snapshot){
          if(snapshot.hasData){
            return const VerifyMailPage();
          }
          return const MyHomePage(title: "Rakshak");
          //return const MyHomePage(title: "Rakshak");
          })
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(
      home: const MapPage(),
    );*/
      Scaffold(
        backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Logo
          const Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                backgroundImage: AssetImage('Assets/Images/logo.png'),
              ),
          ),
         const SizedBox(height: 30),

         //Text
         RichText(
              text: const TextSpan(
                  text: 'WELCOME TO RAKSHAK!',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Colors.black,
                    fontSize: 32,
                    //fontWeight: FontWeight.bold
                  )
              )
          ),

          const SizedBox(height: 7),

          const Text(
            'Your Safety made simpler',
            style: TextStyle(
             color: Colors.black,
              fontSize: 20,
            )
          ),

          const SizedBox(height: 50),

          //Login
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              fixedSize:const Size.fromWidth(300)
            ),
              onPressed: (){
                Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => const LoginPage())
                );
              },
              child: const Text('LOG IN'),
          ),

          const SizedBox(height: 20),

          //Registration
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.deepPurple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              fixedSize: const Size.fromWidth(300),
              side: const BorderSide(color: Colors.deepPurple)
            ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage())
                );
              },
              child: const Text('REGISTRATION')
          )
        ],
      )),
    );
  }
}
