import 'package:flutter/material.dart';
import 'package:umbrella_care/Constants/colors.dart';
import 'package:umbrella_care/Doctor/reviewsPage.dart';
import 'package:umbrella_care/Models/Doctor/doctorAverageReview.dart';
import 'package:umbrella_care/Models/Doctor/doctorModel.dart';
import 'package:umbrella_care/Patient/doctorReview.dart';

class DoctorCard extends StatelessWidget {
  final DoctorInfo doctor;
  final DoctorAverageReview review;
  const DoctorCard({super.key, required this.doctor, required this.review});

  @override
  Widget build(BuildContext context) {
    bool reviewExists = review.noOfReviews!=0;

    return Stack(
     children: [
       Container(
         padding: const EdgeInsets.all(20),
         width: MediaQuery.of(context).size.width,
         height: 115,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(40),
           color: Colors.white,
           boxShadow: [
             BoxShadow(
                 color: Colors.black.withOpacity(0.2),
                 offset: const Offset(0, 3),
                 blurRadius: 6.0,
                 spreadRadius: 2.0
             )
           ],
         ),

         child: Row(
           children: [
             SizedBox(
               height: 80,
               width: 80,
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(30),
                 child: doctor.imgUrl!=''? Image.network(
                   '${doctor.imgUrl}'
                 ) : Image.asset(
                   'assets/doctorImages/doctorPic.png'
                 ),
               )
               // Image.asset(
               //   'assets/doctorImages/doctorProfile.png',
               //   fit: BoxFit.cover,
               // ),
             ),

             const SizedBox(width: 10),

             Flexible(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     doctor.name,
                     softWrap: true,
                     overflow: TextOverflow.ellipsis,
                     style: const TextStyle(
                       fontSize: 22,
                       fontWeight: FontWeight.w700,
                       color: Color(0xFF5E1A84),
                     ),
                   ),

                   const SizedBox(height: 5),

                   Text(
                     doctor.specialization,
                     overflow: TextOverflow.ellipsis,
                     softWrap: true,
                     style: const TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w400,
                       color: Color(0xFF5E1A84),
                     ),
                   ),

                   const SizedBox(height: 5),

                   //review
                   Row(
                     children: [
                       reviewExists? const Icon(
                         Icons.star,
                         size: 15,
                         color: starFill,
                       ) : const Icon(
                         Icons.star_border,
                         size: 15,
                         color: greyBorders,
                       ),

                       const SizedBox(width: 5),

                       Text(
                         reviewExists? '${review.averageRating}' : '0',
                         style: TextStyle(
                           fontWeight: FontWeight.w600,
                           fontSize: 16,
                           color: reviewExists? primary : greyBorders
                         ),
                       ),

                       const SizedBox(width: 5),

                       InkWell(
                         onTap: (){
                           Navigator.push(
                               context,
                             MaterialPageRoute(builder: (context) => ReviewsPage(uid: review.uid))
                           );
                         },
                         child: Text(
                           reviewExists? '(${review.noOfReviews} reviews)' : '(0 reviews)',
                           style: TextStyle(
                             fontSize: 14,
                             fontWeight: FontWeight.w400,
                             color: reviewExists? primary : greyBorders,
                           ),
                         ),
                       )
                     ],
                   )
                 ],
               ),
             ),
           ],
         ),
       ),

       Positioned(
         top: 15,
           right: 15,
           child: IconButton(
             padding: EdgeInsets.zero,
               constraints: const BoxConstraints(),
               onPressed: (){
                  Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context) => DoctorReview(doctor: doctor))
                  );
               },
               icon: const Icon(
                   Icons.star,
                 color: starFill,
               )
           )
       )
     ],
    );
  }
}
