class AppointmentModelTest {
  DateTime appointment;
  String name;
  String speciality;

  AppointmentModelTest(this.appointment,this.name,this.speciality);
}

List<AppointmentModelTest> appointments = appointmentsData
    .map((item) => AppointmentModelTest(DateTime.parse(item['appointment']!), item['name']!, item['speciality']!))
    .toList();

var appointmentsData = [
  {"appointment": "2023-06-08T09:00:00", "name": "Sagat Pokhrel", "speciality": "Cardiologist"},
  {"appointment": "2023-06-09T14:30:00", "name": "Anuj Adhikari", "speciality": "Oncologist"},
];