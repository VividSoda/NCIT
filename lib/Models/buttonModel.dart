class ButtonModel{
  // final String label;
  final String uid;
  bool isSelected;
  final String day, weekDay;

  ButtonModel({
    // required this.label,
    required this.uid,
    this.isSelected = false,
    required this.day,
    required this.weekDay
  });
}

// List<ButtonModel> buttons = buttonsData
//     .map((item) => ButtonModel(
//   //label: item['label']!.toString(),
//     day: item['day'].toString(),
//     weekDay: item['weekDay'].toString(),
//     isSelected:  item.containsKey('isSelected') ?  item['isSelected']! as bool : false))
//     .toList();
//
// var buttonsData = [
//   {
//     // 'label' : 'button 1',
//     'day' : 12,
//     'weekDay' : 'Tue',
//     'isSelected' : true
//   },
//
//   {
//     'day' : 13,
//     'weekDay' : 'Wed',
//     // 'label' : 'button 2'
//   },
//
//   {
//     'day' : 14,
//     'weekDay' : 'Thu',
//     // 'label' : 'button 3'
//   },
//
//   {
//     'day' : 15,
//     'weekDay' : 'Fri',
//     // 'label' : 'button 4'
//   },
//
//   {
//     'day' : 16,
//     'weekDay' : 'Sun',
//     // 'label' : 'button 5'
//   },
//
//   {
//     'day' : 17,
//     'weekDay' : 'Mon',
//     // 'label' : 'button 6'
//   }
// ];
