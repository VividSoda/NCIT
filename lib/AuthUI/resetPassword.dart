import 'package:flutter/material.dart';
import 'package:umbrella_care/AuthUI/passChangedNoti.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _hidePass = true;
  bool _hideConfirmPass = true;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

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
                  'Your password should not be simple',
                  style: TextStyle(
                      color: Color(0xFF5E1A84),
                      fontSize: 16
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  'New password',
                  style: TextStyle(
                      color: Color(0xFF5E1A84),
                      fontSize: 16
                  ),
                ),

                const SizedBox(height: 10),

                //Pass
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Enter Password!!!";
                    }

                    else if(value.length<9){
                      return "Password should be at least 8 characters long!!!";
                    }

                    else{
                      return null;
                    }
                  } ,
                  obscureText: _hidePass,
                  controller: _password,
                  decoration: InputDecoration(
                      hintText: 'Must be 8 characters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF5E1A84)
                          )
                      ),
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _hidePass = !_hidePass;
                            });
                          },
                          icon: _hidePass? const Icon(
                            Icons.visibility_off,
                            color: Color(0xFF5E1A84),
                          ) : const Icon(
                              Icons.visibility,
                              color: Color(0xFF5E1A84)
                          )
                      )
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Confirm new password',
                  style: TextStyle(
                      color: Color(0xFF5E1A84),
                      fontSize: 16
                  ),
                ),

                const SizedBox(height: 10),

                //Confirm Pass
                TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Enter Password!!!";
                    }

                    else if(value != _password.text){
                      return "Confirm Password must be same as Password!!!";
                    }

                    else{
                      return null;
                    }
                  } ,
                  obscureText: _hideConfirmPass,
                  decoration: InputDecoration(
                      hintText: 'repeat password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF5E1A84)
                          )
                      ),
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _hideConfirmPass = !_hideConfirmPass;
                            });
                          },
                          icon: _hideConfirmPass? const Icon(
                            Icons.visibility_off,
                            color: Color(0xFF5E1A84),
                          ) : const Icon(
                              Icons.visibility,
                              color: Color(0xFF5E1A84)
                          )
                      )
                  ),
                ),

                const SizedBox(height: 30),

                //Reset password button
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (){
                        Navigator.push(
                            context,
                          MaterialPageRoute(builder: (context) => const PassChangedNoti())
                        );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E1A84),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: const Text(
                      'Reset password',
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
