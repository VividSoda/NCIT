// //get download url
// static Future<String?> getDownloadUrl(String destination) async {
// try {
// final ref = FirebaseStorage.instance.ref(destination);
//
// final downloadUrl = await ref.getDownloadURL();
// return downloadUrl;
// } catch (FirebaseException) {
// return null;
// }
// }
//
// //get records ids form patients uploaded by doctor
// Future<List<PdfModel>> getPdfInfo() async{
//   List<PdfModel> records = [];
//
//   String patientId = widget.doctorUploadedReport.patientId;
//
//   final document = FirebaseFirestore.instance.collection('patients').doc(patientId).collection('records');
//
//   QuerySnapshot snapshot = await document.get();
//
//   for (var doc in snapshot.docs) {
//     Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
//
//     List<dynamic> list = data!['record ids'];
//
//     List<String> patientRecords = list.cast<String>();
//
//     //get record details form records collection
//     for(int i = 0; i < patientRecords.length; i++){
//       Map<String,String> pdfDetails = await fetchPdf(patientRecords[i]);
//
//       String dateString = pdfDetails['date']!;
//
//
//       PdfModel pdfModel = PdfModel(
//           name: pdfDetails['name']!,
//           path: pdfDetails['path']!,
//           url: pdfDetails['url']!,
//           dateCreated: DateTime.parse(dateString)
//       );
//
//       records.add(pdfModel);
//     }
//   }
//   return records;
// }
//
// //get record details form records collection
// Future<Map<String, String>> fetchPdf(String recordId) async{
//   final record = FirebaseFirestore.instance.collection('records').doc(recordId);
//
//   DocumentSnapshot<Map<String, dynamic>> snapshot = await record.get();
//   Map<String, dynamic> data = snapshot.data()!;
//
//   String name = data['name'];
//   String path = data['record path'];
//
//   final reference = FirebaseStorage.instance.ref().child(path);
//
//   String url = await reference.getDownloadURL();
//
//   String date = data['date created'];
//
//   return {'name' : name, 'path' : path, 'url' : url, 'date' : date};
// }
//
// //assign records list
// Future<void> fetchReports() async {
//   List<PdfModel> fetchedPdfs = await getPdfInfo();
//   setState(() {
//     pdfList = fetchedPdfs;
//     _isLoading = false;
//   });
// }