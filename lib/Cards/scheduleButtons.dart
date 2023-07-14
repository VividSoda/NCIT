import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_care/Constants/colors.dart';
import 'package:umbrella_care/Models/buttonModel.dart';

class ScheduleButtons extends StatelessWidget {
  final ButtonModel button;
  final VoidCallback onPressed;

  const ScheduleButtons({Key? key, required this.button, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 70,
        // height: 84,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: button.isSelected? primary : fadedPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   button.label,
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w800,
                //     color: Colors.white
                //   ),
                // ),
                Text(
                  button.day,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  button.weekDay,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
