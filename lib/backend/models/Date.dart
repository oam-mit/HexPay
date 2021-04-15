import 'package:intl/intl.dart';

class Date {
  String formattedDate;

  Date(String datetime) {
    DateTime date = DateTime.parse(datetime).toLocal();
    formattedDate = DateFormat('d MMMM yyyy @ H:mm, E').format(date);
  }
}
