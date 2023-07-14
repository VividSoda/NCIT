import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:umbrella_care/Constants/colors.dart';
import 'package:umbrella_care/Models/Doctor/doctorModel.dart';
import 'package:umbrella_care/Patient/patientHome.dart';

class DoctorReview extends StatefulWidget {
  final DoctorInfo doctor;
  const DoctorReview({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorReview> createState() => _DoctorReviewState();
}

class _DoctorReviewState extends State<DoctorReview> {
  final TextEditingController _review = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  double _rating = 0;
  String? _name;
  double _averageRating = 0;
  int _numberOfReviews = 0;
  final List<double> _allRatings = [];
  String _imgUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPatientDetails();
    fetchDoctorDetails();
  }

  //check if review already exists
  Future<bool> checkReviewExists() async{
    final userDoc = FirebaseFirestore.instance.collection('doctors').doc(widget.doctor.uid).collection('reviews').doc(currentUser!.uid);

    DocumentSnapshot<Map<String, dynamic>> snapshot = await userDoc.get();

    if(snapshot.exists){
      return true;
    }

    return false;
  }

  //fetch patient Details
  Future<void> fetchPatientDetails() async{
    print('@@@@@@fetch patient@@@@');
    final user = FirebaseFirestore.instance.collection('patients').doc(currentUser!.uid);
    DocumentSnapshot<Map<String, dynamic>> snapshot = await user.get();
    Map<String, dynamic> data = snapshot.data()!;

    _name = data['name'];

    final userReview = FirebaseFirestore.instance.collection('patients').doc(currentUser!.uid).collection('reviews').doc(widget.doctor.uid);
    DocumentSnapshot<Map<String, dynamic>> snapshotReview = await userReview.get();

    if(snapshotReview.exists){
      print('@@@@review exists@@@@');
      Map<String, dynamic> dataReview = snapshotReview.data()!;

      setState(() {
        _rating = dataReview['rating'];
      });
      _review.text = dataReview['review'];
    }
  }

  //Fetch doctor details
  Future<void> fetchDoctorDetails() async{
    final user = FirebaseFirestore.instance.collection('doctors').doc(widget.doctor.uid);
    DocumentSnapshot<Map<String, dynamic>> snapshot = await user.get();

    if(snapshot.exists){
      Map<String, dynamic> data = snapshot.data()!;

      if(data['averageRating']!=null){
        dynamic item = data['averageRating'];
        setState(() {
          _averageRating = item.toDouble();
        });
      }

      if(data['noOfReviews']!=null){
        setState(() {
          _numberOfReviews = data['noOfReviews'];
        });
      }

      if(data['img url']!=null){
        setState(() {
          _imgUrl = data['img url'];
        });
      }
    }
  }

  //create rating in doctor database
  Future<void> createRatingInDoctor() async{
    final user = FirebaseFirestore.instance.collection('doctors').doc(widget.doctor.uid).collection('reviews').doc(currentUser!.uid);

    return user.set({
      'patient id' : currentUser!.uid,
      'name' : _name,
      'rating' : _rating,
      'review' : _review.text
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Review created successfully',
              )
          )
      );
    }).catchError((error){
      print('Failed to create user : $error');
    });
  }

  //create rating in patient database
  Future<void> createRatingInPatient() async{
    _numberOfReviews++;
    final user = FirebaseFirestore.instance.collection('patients').doc(currentUser!.uid).collection('reviews').doc(widget.doctor.uid);

    return user.set({
      'doctor id' : widget.doctor.uid,
      'name' : widget.doctor.name,
      'rating' : _rating,
      'review' : _review.text
    });
  }

  //update rating in doctor database
  Future<void> updateRatingInDoctor() async{
    final user = FirebaseFirestore.instance.collection('doctors').doc(widget.doctor.uid).collection('reviews').doc(currentUser!.uid);

    return user.update({
      'rating' : _rating,
      'review' : _review.text
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Review updated successfully',
              )
          )
      );
    }).catchError((error){
      print('Failed to update user: $error');
    });
  }

  //update rating in patient database
  Future<void> updateRatingInPatient() async{
    final user = FirebaseFirestore.instance.collection('patients').doc(currentUser!.uid).collection('reviews').doc(widget.doctor.uid);

    return user.set({
      'rating' : _rating,
      'review' : _review.text
    });
  }

  //calculate average
  Future<double> calculateAverage() async{
    final reviews = FirebaseFirestore.instance.collection('doctors').doc(widget.doctor.uid).collection('reviews');

    QuerySnapshot snapshot = await reviews.get();

    for(var doc in snapshot.docs){
      Map<String,dynamic>? data = doc.data() as Map<String, dynamic>?;

      double rating = data!['rating'];

      _allRatings.add(rating);
    }

    double average = 0;
    double sum = 0;
    for(int i=0; i<_allRatings.length; i++){
      sum = sum + _allRatings[i];
    }

    average = sum/_allRatings.length;
    average = double.parse(average.toStringAsFixed(1));

    return average;
  }

  //update average and no of reviews in doctor
  Future<void> updateAverageDoctor() async{

    _averageRating = await calculateAverage();

    final doctor = FirebaseFirestore.instance.collection('doctors').doc(widget.doctor.uid);

    return doctor.update({
      'averageRating' : _averageRating,
      'noOfReviews' : _numberOfReviews
    }).then((value) {
      print('Updated successfully!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      Navigator.push(
          context,
        MaterialPageRoute(builder: (context) => const PatientHome())
      );
    }).catchError((error){
      print('Failed to update average : $error');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _review.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('##############$_rating');
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 50),

              //Back Button
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        border: Border.all(color: greyBorders),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: primary
                      ),
                    ),
                  ),

                  const SizedBox(width: 60),

                  const Text(
                    'Doctor Review',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: primary
                    ),
                  )
                ],
              ),

              const SizedBox(height: 40),

              //Doctor pic
              SizedBox(
                width: 104,
                height: 104,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: _imgUrl!=''? Image.network(
                    _imgUrl
                  ) : Image.asset(
                    'assets/doctorImages/doctorPic.png'
                  ),
                )
                // Image.asset(
                //   'assets/doctorImages/doctorProfile.png',
                //   fit: BoxFit.cover,
                // ),
              ),

              const SizedBox(height: 20),

              Text(
                'Dr. ${widget.doctor.name}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: primary
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                widget.doctor.specialization,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: primary
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: starFill,
                    size: 15,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    '$_averageRating',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primary
                    ),
                  ),

                  const SizedBox(width: 5),

                  //No of reviews
                  Text(
                    '($_numberOfReviews Reviews)',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: primary
                    ),
                  )
                ],
              ),

              const SizedBox(height: 50),

              //Review
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Review',
                  style: TextStyle(
                      color: Color(0xFF5E1A84),
                      fontSize: 19,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //Review
              SizedBox(
                height: 152,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  maxLines: 6,
                  controller: _review,
                  decoration: InputDecoration(
                    hintText: 'Write a Review',
                    filled: true,
                    fillColor: containerFill,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //Rating Bar
              RatingBar.builder(
                allowHalfRating: true,
                initialRating: _rating,
                  minRating: 0,
                  unratedColor: Colors.grey,
                  itemCount: 5,
                  itemSize: 32,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                  updateOnDrag: true,
                  itemBuilder: (context, index){
                    return const Icon(
                        Icons.star,
                      color: starFill,
                    );
                  },
                  onRatingUpdate: (rating){
                    setState(() {
                      _rating = rating;
                    });
                  }
              ),

              const SizedBox(height: 10),

              //Rating Bar index
              Text(
                'Rating : $_rating',
                style: const TextStyle(
                  color: primary
                ),
              ),
              // SizedBox(
              //   height: 32,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //       itemCount: 5,
              //       shrinkWrap: true,
              //       itemBuilder: (context, index){
              //         return const Icon(
              //           Icons.star,
              //           color: starFill,
              //           size: 32,
              //         );
              //       }
              //   ),
              // ),

              const SizedBox(height: 50),

              //Submit Button
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    bool reviewExists = await checkReviewExists();
                    print('----------------$reviewExists-------------');

                    if(reviewExists){
                      await updateRatingInPatient();
                      await updateRatingInDoctor();
                    }

                    else{
                      await createRatingInDoctor();
                      await createRatingInPatient();
                    }

                    await updateAverageDoctor();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5E1A84),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
