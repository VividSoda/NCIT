import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SirenPage extends StatefulWidget {
  const SirenPage({Key? key}) : super(key: key);

  @override
  State<SirenPage> createState() => _SirenPageState();
}

class _SirenPageState extends State<SirenPage> {
  final player = AudioPlayer();
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: (){
              ModalRoute.of(context)?.canPop;
            },
            icon: const Icon(Icons.arrow_back_ios)
        ),
        title: const Text('Siren'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  child: Lottie.asset(
                      "Assets/Animations/siren_animation.json", height: 300,
                      width: 300
                  ),
                  onTap: (){
                    setState(() {
                      playing = !playing;
                      playing? player.play(AssetSource('Audios/siren.mp3')): player.stop();
                    });
                  },
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  fixedSize: const Size(185, 50)
                ),
                  onPressed: (){
                    setState(() {
                      playing = !playing;
                      playing? player.play(AssetSource('Audios/siren.mp3')): player.stop();
                    });
                  },
                  child:const Text('Siren')
              ),
            ],
          ),
        ),
      ),
    );
  }
}