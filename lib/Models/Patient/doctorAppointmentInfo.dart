class DoctorAppointmentInfo {
  final DateTime appointmentDate;
  final String name;
  final String speciality;
  // final List<int> bookedTimes;
  final int bookedTime;
  String? imgUrl = '';

  DoctorAppointmentInfo(
      {
        required this.appointmentDate,
        required this.name,
        required this.speciality,
        // required this.bookedTimes
        required this.bookedTime,
        this.imgUrl
      });
}

// List<AppointmentInfo> appointments = appointmentsData
//     .map((item) => AppointmentInfo(DateTime.parse(item['appointment']!), item['name']!, item['speciality']!))
//     .toList();
//
// var appointmentsData = [
//   {"appointment": "2023-06-08T09:00:00", "name": "Sagat Pokhrel", "speciality": "Cardiologist"},
//   {"appointment": "2023-06-09T14:30:00", "name": "Anuj Adhikari", "speciality": "Oncologist"},
// ];