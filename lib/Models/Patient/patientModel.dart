class PatientInfo {
  final String uid, name, contact;
  String? imgUrl = '';
  //final String dob, bloodGroup, weight, feet, inches;

  PatientInfo({
    required this.uid,
    required this.name,
    required this.contact,
    this.imgUrl
    // required this.dob,
    // required this.bloodGroup,
    // required this.weight,
    // required this.feet,
    // required this.inches
  });
}