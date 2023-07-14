import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_care/Cards/Doctor/doctorCard.dart';
import 'package:umbrella_care/Constants/colors.dart';
import 'package:umbrella_care/Models/Doctor/doctorAverageReview.dart';
import 'package:umbrella_care/Models/Doctor/doctorModel.dart';
import 'package:umbrella_care/Patient/doctorDetails.dart';

class HospitalDoctors extends StatefulWidget {
  final String hospitalName;
  const HospitalDoctors({Key? key, required this.hospitalName}) : super(key: key);

  @override
  State<HospitalDoctors> createState() => _HospitalDoctorsState();
}

class _HospitalDoctorsState extends State<HospitalDoctors> {
  bool _isLoading = true;
  List<DoctorInfo> affiliatedDoctors = [];
  List<DoctorAverageReview> reviews = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   fetchData();
  }

  //fetch data
  void fetchData() async{
    await assignReviewData();
    fetchDoctors();
  }

  //assign review data
  Future<void> assignReviewData() async {
    List<DoctorAverageReview> fetchedReviews = await getReviewData();
    setState(() {
      reviews = fetchedReviews;
    });
  }

  //get review data
  Future<List<DoctorAverageReview>> getReviewData() async{
    List<DoctorAverageReview> reviews = [];
    final doctors = FirebaseFirestore.instance.collection('doctors');

    QuerySnapshot snapshot = await doctors.get();

    for(var doc in snapshot.docs){
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      if(data!.containsKey('validity')){
        String affiliations = data['affiliations'].toString().toLowerCase();

        if(affiliations.contains(widget.hospitalName.toLowerCase())){
          String specialization = data['specialization'];
          String uid = doc.id;
          if(data.containsKey('averageRating')){
            print('=========exists===');
            double averageRating = data['averageRating'];
            int noOfReviews = data['noOfReviews'];
            // String specialization = data['specialization'];

            DoctorAverageReview doctorAverageReview = DoctorAverageReview(
                averageRating: averageRating,
                noOfReviews: noOfReviews,
                specialization: specialization,
                affiliations: affiliations,
              uid: uid
            );
            reviews.add(doctorAverageReview);
          }

          else{
            //String specialization = data['specialization'];

            DoctorAverageReview doctorAverageReview = DoctorAverageReview(
                specialization: specialization,
                affiliations: affiliations,
              uid: uid
            );
            reviews.add(doctorAverageReview);
          }
        }
      }
    }
    return reviews;
  }

  //assign doctor list
  void fetchDoctors() async{
   List<DoctorInfo> fetchedDoctors = await getDoctorsFromFirebase();
   setState(() {
     affiliatedDoctors = fetchedDoctors;
     _isLoading = false;
   });
  }

  //get doctor list from firebase
  Future<List<DoctorInfo>> getDoctorsFromFirebase() async{
    List<DoctorInfo> doctors = [];

    final documents = FirebaseFirestore.instance.collection('doctors');

    QuerySnapshot snapshot = await documents.get();

    for(var doc in snapshot.docs){
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      if(data!.containsKey('validity')){
        String affiliations = data['affiliations'].toString().toLowerCase();

        if(affiliations.contains(widget.hospitalName.toLowerCase())){
          String uid = doc.id;
          String name = data['name'];
          String nmcNo = data['nmc no'];
          String contact = data['contact'];
          String qualifications = data['qualifications'];
          String experience = data['experience'];
          String specialization = data['specialization'];
          bool validity = data['validity'];
          String imgUrl = '';
          if(data.containsKey('img url')){
            imgUrl = data['img url'];
          }

          DoctorInfo doctor = DoctorInfo(
              uid: uid,
              name: name,
              nmcNo: nmcNo,
              contact: contact,
              qualifications: qualifications,
              affiliations: affiliations,
              experience: experience,
              specialization: specialization,
              validity: validity,
            imgUrl: imgUrl
          );
          doctors.add(doctor);
        }
      }
    }

    return doctors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed:() {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: primary,
            )
        ),
        title: const Text(
          'Available Doctors',
          style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w700,
              color: primary
          ),
        ),
      ),

      body: Padding(
          padding: const EdgeInsets.all(20),
        child: _isLoading? const Center(
          child: CircularProgressIndicator(),
        ) : ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: affiliatedDoctors.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async{
                print('---------pressed--------');
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorDetails(uid: affiliatedDoctors[index].uid))
                );
              },
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: DoctorCard(doctor: affiliatedDoctors[index], review: reviews[index])
                ),
              );
          },
        ),
        ),
    );
  }
}
