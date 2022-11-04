import 'package:flutter/material.dart';

class CustomizeMessagePage extends StatefulWidget {
  const CustomizeMessagePage({Key? key}) : super(key: key);

  @override
  State<CustomizeMessagePage> createState() => _CustomizeMessagePageState();
}

class _CustomizeMessagePageState extends State<CustomizeMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: (){

            },
            icon: const Icon(Icons.arrow_back_ios)
        ),
        title: const Text('Customize Message'),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  height: 80,
                  color: const Color(0xFF7A26C1),
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      'Assets/Images/robbery.PNG',
                      height: 80,
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pop(context,"Robbery nearby ");
                },
              ),

              const SizedBox(height: 10,),

              GestureDetector(
                child: Container(
                    height: 80,
                    color: const Color(0xFF7A26C1),
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'Assets/Images/fuel.png',
                        height: 80,
                      ),
                    )
                ),
                onTap: (){
                  Navigator.pop(context,"I am stuck without fuel ");
                },
              ),

              const SizedBox(height: 10,),

              GestureDetector(
                child: Container(
                    height: 80,
                    color: const Color(0xFF7A26C1),
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'Assets/Images/fighting.PNG',
                        height: 80,
                      ),
                    )
                ),
                onTap: (){
                  Navigator.pop(context,"I might be in a brawl ");
                },
              ),

              const SizedBox(height: 10),

              GestureDetector(
                child: Container(
                    height: 80,
                    color: const Color(0xFF7A26C1),
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'Assets/Images/suspicious.PNG',
                        height: 80,
                      ),
                    )
                ),
                onTap: (){
                  Navigator.pop(context,"Suspicious person nearby ");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
