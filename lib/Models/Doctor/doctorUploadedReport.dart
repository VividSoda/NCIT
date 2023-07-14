import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorUploadedReport{
  final String docId, patientId;
  final List<String> reportIds;
  final DateTime dateCreated;
  final String name;
  final String specialization;
  final String affiliation;
  String? imgUrl= '';

  DoctorUploadedReport({
    required this.docId,
    required this.patientId,
    required this.reportIds,
    required this.dateCreated,
    required this.name,
    required this.specialization,
    required this.affiliation,
    this.imgUrl
  });
}

// class DoctorUploadedReport{
//   final String docId, patientId;
//   final List<String> reportIds;
//   final DateTime dateCreated;
//   String name = '';
//   String specialization = '';
//   String affiliation = '';
//
//   DoctorUploadedReport({
//     required this.docId,
//     required this.patientId,
//     required this.reportIds,
//     required this.dateCreated,
//   }){
//     _initialize();
//   }
//
//   Future<void> _initialize() async {
//     await fetchDoctorDetails();
//   }
//
//   //Fetch doctor details
//   Future<void> fetchDoctorDetails() async {
//     final doctorDoc = FirebaseFirestore.instance.collection('doctors').doc(docId);
//
//     DocumentSnapshot<Map<String, dynamic>> snapshot = await doctorDoc.get();
//
//     Map<String, dynamic> data = snapshot.data()!;
//
//     name = data['name'];
//     specialization = data['specialization'];
//     affiliation = data['affiliations'];
//   }
// }