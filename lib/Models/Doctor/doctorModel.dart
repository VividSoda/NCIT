class DoctorInfo {
  final String uid, name, nmcNo, contact, qualifications, affiliations, experience, specialization;
  final bool validity;
  String? imgUrl = '';
  double? avgRating = 0.0;
  int? noOfReviews = 0;

  DoctorInfo(
      {
        required this.uid,
        required this.name,
        required this.nmcNo,
        required this.contact,
        required this.qualifications,
        required this.affiliations,
        required this.experience,
        required this.specialization,
        required this.validity,
        this.imgUrl,
        this.avgRating,
        this.noOfReviews
      }
      );
}

// List<DoctorInfo> doctors = [
//   DoctorInfo(
//     name: "Event 1",
//     speciality: "Speciality here"
//   ),
//
//   DoctorInfo(
//       name: "Event 2",
//       speciality: "Speciality here"
//   ),
//
//   DoctorInfo(
//       name: "Event 3",
//       speciality: "Speciality here"
//   ),
//
//   DoctorInfo(
//       name: "Event 4",
//       speciality: "Speciality here"
//   ),
//
//   DoctorInfo(
//       name: "Event 5",
//       speciality: "Speciality here"
//   ),
//
//   DoctorInfo(
//       name: "Event 6",
//       speciality: "Speciality here"
//   ),
//
//   DoctorInfo(
//       name: "Event 7",
//       speciality: "Speciality here"
//   ),
//
//   DoctorInfo(
//       name: "Event 8",
//       speciality: "Speciality here"
//   ),
//
//   DoctorInfo(
//       name: "Event 9",
//       speciality: "Speciality here"
//   ),
//
//   DoctorInfo(
//       name: "Event 10",
//       speciality: "Speciality here"
//   ),
//];
